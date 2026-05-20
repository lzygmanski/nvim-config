local parser_install_dir = vim.fn.stdpath 'data' .. '/treesitter'

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  opts = {
    parser_install_dir = parser_install_dir,
    ensure_installed = {
      'bash',
      'c',
      'css',
      'diff',
      'dockerfile',
      'gitignore',
      'html',
      'javascript',
      'jsdoc',
      'json',
      'jsonc',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'python',
      'query',
      'regex',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'yaml',
    },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = false },
  },
  config = function(_, opts)
    -- lazy.nvim rebuilds runtimepath during startup, so add this right before setup.
    vim.opt.runtimepath:remove(parser_install_dir)
    vim.opt.runtimepath:prepend(parser_install_dir)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
