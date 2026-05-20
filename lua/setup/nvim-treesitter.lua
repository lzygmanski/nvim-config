local parser_install_dir = vim.fn.stdpath 'data' .. '/treesitter'

vim.opt.runtimepath:prepend(parser_install_dir)

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
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
}
