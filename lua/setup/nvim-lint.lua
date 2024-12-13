return {
  'mfussenegger/nvim-lint',
  config = function()
    require('lint').linters_by_ft = {
      lua = { 'luacheck' },
      python = { 'flake8' },
      sh = { 'bashls' },
    }

    local lint_augroup = vim.api.nvim_create_augroup('LintGroup', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
      group = lint_augroup,
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}
