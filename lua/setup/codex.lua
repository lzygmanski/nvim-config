return {
  'johnseth97/codex.nvim',
  cmd = { 'Codex', 'CodexToggle' },
  keys = {
    {
      '<leader>cc',
      '<cmd>CodexToggle<CR>',
      desc = 'Toggle Codex',
      mode = { 'n', 't' },
    },
  },
}
