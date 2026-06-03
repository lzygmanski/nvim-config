local parser_install_dir = vim.fn.stdpath 'data' .. '/treesitter'
local has_tree_sitter_cli = vim.fn.executable 'tree-sitter' == 1

local ensure_installed = {
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
}

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = function()
    if has_tree_sitter_cli then
      require('nvim-treesitter').update():wait(300000)
    end
  end,
  opts = {
    ensure_installed = ensure_installed,
    install_dir = parser_install_dir,
  },
  config = function(_, opts)
    local nvim_treesitter = require 'nvim-treesitter'

    nvim_treesitter.setup {
      install_dir = opts.install_dir,
    }

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('nvim-treesitter-start', { clear = true }),
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })

    if not has_tree_sitter_cli then
      vim.schedule(function()
        vim.notify(
          table.concat({
            'nvim-treesitter parser installs are disabled because `tree-sitter` is not on PATH.',
            'Install `tree-sitter-cli` first, for example with `brew install tree-sitter-cli`.',
          }, ' '),
          vim.log.levels.WARN
        )
      end)
      return
    end

    local installed = nvim_treesitter.get_installed 'parsers'
    local missing = vim.tbl_filter(function(lang)
      return not vim.list_contains(installed, lang)
    end, opts.ensure_installed)

    if #missing > 0 then
      nvim_treesitter.install(missing, { summary = true })
    end
  end,
}
