vim.diagnostic.config {
  signs = { severity_limit = 'Hint' },
  virtual_text = {
    spacing = 1,
    prefix = '·',
    severity_limit = 'Warning',
    -- format = function()
    --   return ''
    -- end,
  },
  float = {
    border = 'rounded',
  },
  update_in_insert = false,
}

-- local signs = { Error = "", Warn = "", Hint = "󰋗", Info = "󰋼" }
local signs = { Error = '·', Warn = '·', Hint = '·', Info = '·' }

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating [d]iagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
