require("core.basic")
require("core.lazy")

require("lazy").setup({
  -- Theme
  {
    "dracula/vim",
    name = "dracula"
  },
  {
    "rcarriga/nvim-notify",
    opts = { background_colour = "#000000" }
  },
  "stevearc/dressing.nvim",

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
    "nvim-tree/nvim-tree.lua",
    tag = "nightly",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      "windwp/nvim-ts-autotag",
      "windwp/nvim-autopairs"
    },
  },

  -- Lsp
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "b0o/schemastore.nvim",
      { 'j-hui/fidget.nvim', opts = {} },
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
      'onsails/lspkind.nvim'
    }
  },

  -- Git
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  { "lewis6991/gitsigns.nvim",       opts = {} },

  -- Others
  "ThePrimeagen/vim-be-good",
  "mbbill/undotree",
  "tpope/vim-sleuth",                             -- alternative to "editorconfig/editorconfig-vim"
  { 'folke/which-key.nvim',          opts = {} },
  { 'numToStr/Comment.nvim',         opts = {} }, -- alternative to "tpope/vim-commentary",
  { "simrat39/symbols-outline.nvim", opts = {} },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- TODO conform

  -- TODO lint

  -- TODO cspell
})

-- Theme
require('setups.theme')

-- Navigation
require('setups.nvim-tree')
require('setups.telescope')

-- Treesitter
require('setups.nvim-treesitter')

-- Lsp
require('setups.lspconfig')

-- Autocompletion
require('setups.nvim-cmp')

-- Others
---- Undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "[U]ndo tree" })

---- Symbols
vim.keymap.set("n", "<leader>s", vim.cmd.SymbolsOutline, { desc = "[S]ymbol outline" })

--- Notify
require("telescope").load_extension("notify")
vim.notify = require("notify")
