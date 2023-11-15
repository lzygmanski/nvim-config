require('dracula').setup {
  show_end_of_buffer = true,
  transparent_bg = true,
  italic_comment = true,
}

vim.cmd.colorscheme 'dracula'

vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#282A36' })

require('telescope').load_extension 'notify'
vim.notify = require 'notify'
