-- Formatters
require('conform').setup {
  formatters_by_ft = {
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescriptreact = { 'prettier' },
    svelte = { 'prettier' },
    css = { 'prettier' },
    html = { 'prettier' },
    json = { 'prettier' },
    yaml = { 'prettier' },
    markdown = { 'prettier' },
    graphql = { 'prettier' },
    python = { 'prettier' },
    lua = { 'stylua' },
  },
  format_on_save = {
    async = false,
    timeout_ms = 500,
    lsp_fallback = true,
  },
}
-- Linters
require('lint').linters_by_ft = {
  lua = { 'luacheck' },
  python = { 'flake8' },
  sh = { 'bashls' },
}

local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
  group = lint_augroup,
  callback = function()
    require('lint').try_lint()
  end,
})

-- TODO null-ls is not supported now - to replace
local config = {
  find_json = function()
    return os.getenv 'HOME' .. '/' .. '.cspell.json'
  end,
}

require('null-ls').setup {
  sources = {
    require('cspell').diagnostics.with {
      diagnostics_postprocess = function(diagnostic)
        diagnostic.message = ''
        diagnostic.severity = vim.diagnostic.severity.INFO
      end,
      find_json = config.find_json,
    },
    require('cspell').code_actions.with {
      find_json = config.find_json,
    },
  },
}
