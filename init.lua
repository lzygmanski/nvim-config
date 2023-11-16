hello = [[
██╗  ██╗███████╗██╗     ██╗      ██████╗         ██╗    ██╗ ██████╗ ██████╗ ██╗     ██████╗ ██╗
██║  ██║██╔════╝██║     ██║     ██╔═══██╗        ██║    ██║██╔═══██╗██╔══██╗██║     ██╔══██╗██║
███████║█████╗  ██║     ██║     ██║   ██║        ██║ █╗ ██║██║   ██║██████╔╝██║     ██║  ██║██║
██╔══██║██╔══╝  ██║     ██║     ██║   ██║        ██║███╗██║██║   ██║██╔══██╗██║     ██║  ██║╚═╝
██║  ██║███████╗███████╗███████╗╚██████╔╝        ╚███╔███╔╝╚██████╔╝██║  ██║███████╗██████╔╝██╗
╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝ ╚═════╝          ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝

]]

require 'core.basic'
require 'core.lazy'

require('lazy').setup {
  -- Theme
  {
    'Mofiqul/dracula.nvim',
    name = 'dracula',
  },
  {
    'rcarriga/nvim-notify',
    opts = { background_colour = '#000000' },
  },
  'stevearc/dressing.nvim',

  -- Navigation
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },
  {
    'nvim-tree/nvim-tree.lua',
    tag = 'nightly',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'windwp/nvim-ts-autotag',
      'windwp/nvim-autopairs',
    },
  },

  -- Lsp
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'b0o/schemastore.nvim',
      {
        'j-hui/fidget.nvim',
        opts = {
          notification = {
            window = {
              winblend = 0,
              border = 'rounded',
            },
          },
        },
      },
      'folke/neodev.nvim',
    },
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'rafamadriz/friendly-snippets',
      'onsails/lspkind.nvim',
    },
  },

  -- Linters & Formatters
  { 'stevearc/conform.nvim' },
  { 'mfussenegger/nvim-lint' },
  {
    'davidmh/cspell.nvim',
    dependencies = {
      { 'jose-elias-alvarez/null-ls.nvim' },
    },
  },

  -- Git
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  { 'lewis6991/gitsigns.nvim', opts = {} },

  -- Note Taking
  {
    'nvim-neorg/neorg',
    build = ':Neorg sync-parsers',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- Dashboard
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },

  -- Others
  'ThePrimeagen/vim-be-good',
  'mbbill/undotree',
  'tpope/vim-sleuth', -- alternative to "editorconfig/editorconfig-vim"
  { 'folke/which-key.nvim', opts = {} },
  { 'numToStr/Comment.nvim', opts = {} }, -- alternative to "tpope/vim-commentary",
  { 'simrat39/symbols-outline.nvim', opts = {} },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      exclude = { filetypes = { 'dashboard', 'lspinfo', 'checkhealth', 'help', 'man', 'NvimTree' } },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        component_separators = '·',
        section_separators = '',
      },
    },
  },
}

-- Theme
require 'setups.theme'

-- Navigation
require 'setups.nvim-tree'
require 'setups.telescope'

-- Treesitter
require 'setups.nvim-treesitter'

-- Lsp
require 'setups.lspconfig'

-- Autocompletion
require 'setups.nvim-cmp'

-- Linters & Formatters
require 'setups.lint-format'
require 'setups.diagnostic'

-- Note Taking
require 'setups.neorg'

-- Dashboard
require 'setups.dashboard'

-- Others
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[U]ndo tree' })
vim.keymap.set('n', '<leader>s', vim.cmd.SymbolsOutline, { desc = '[S]ymbol outline' })
