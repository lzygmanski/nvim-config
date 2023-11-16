require('neorg').setup {
  load = {
    ['core.defaults'] = {},
    ['core.concealer'] = {},
    ['core.dirman'] = {
      config = {
        workspaces = {
          notes = '~/notes',
        },
        default_workspace = 'notes',
      },
    },
  },
}

vim.keymap.set('n', '<leader>n', vim.cmd.Neorg, { desc = '[N]eorg' })
