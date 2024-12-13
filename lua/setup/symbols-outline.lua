return {
  'simrat39/symbols-outline.nvim',
  init = function()
    vim.keymap.set('n', '<leader>s', vim.cmd.SymbolsOutline, { desc = '[S]ymbol outline' })
  end,
  opts = {},
}

