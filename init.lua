require("core.basic")
require("core.lazy")

require("lazy").setup({
  -- Theme
  {
    "dracula/vim",
    name = "dracula"
  },

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
    }
  },

  -- Git
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Basic
  "tpope/vim-sleuth", -- alternative to "editorconfig/editorconfig-vim"
  { 'folke/which-key.nvim', opts = {} },
  { 'numToStr/Comment.nvim', opts = {} }, -- alternative to "tpope/vim-commentary",
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

  -- Learning
  "ThePrimeagen/vim-be-good",
})

-- Theme
vim.cmd.colorscheme("dracula")
vim.api.nvim_set_option("termguicolors", true)
vim.api.nvim_set_option("background", "dark")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#282A36" })

-- Navigation
require('setups.nvim-tree')
require('setups.telescope')

-- Treesitter
require('setups.nvim-treesitter')

-- Lsp
require('setups.lspconfig')

-- Autocompletion
require('setups.nvim-cmp')
