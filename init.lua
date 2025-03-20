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
require 'core.diagnostic'

require('lazy').setup {
  -- Theme
  require 'setup/theme',
  require 'setup/nvim-notify',
  'stevearc/dressing.nvim',

  -- Navigation
  require 'setup.telescope',
  require 'setup.nvim-tree',

  -- LSP & DAP installation
  require 'setup.mason',

  -- DAP
  require 'setup.nvim-dap',

  -- LSP
  require 'setup.lazydev',
  require 'setup.nvim-lspconfig',
  { 'Bilal2453/luvit-meta', lazy = true },

  -- Treesitter
  require 'setup.nvim-treesitter',

  -- Git
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  { 'lewis6991/gitsigns.nvim', opts = {} },

  -- Autocompletion
  require 'setup.nvim-cmp',
  require 'setup.chat-gpt',

  -- Linters & Formatters
  require 'setup.conform',
  require 'setup.nvim-lint',

  -- Helpers
  require 'setup.dashboard',
  require 'setup.symbols-outline',
  require 'setup.undotree',
  require 'setup.which-key',
  require 'setup.todo-comments',
  require 'setup.lualine',
  require 'setup.indent-blankline',
  require 'setup.vim-tmux-navigator',
  'tpope/vim-sleuth', -- alternative to "editorconfig/editorconfig-vim"
  { 'numToStr/Comment.nvim', opts = {} }, -- alternative to "tpope/vim-commentary",
}
