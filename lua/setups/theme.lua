require('dracula').setup {
  show_end_of_buffer = true,
  transparent_bg = true,
  italic_comment = true,
  overrides = function(colors)
    return {
      TelescopeNormal = { fg = colors.fg, bg = 'none' },
      Pmenu = { fg = colors.white, bg = 'none' },
      PmenuSbar = { bg = 'none' },
    }
  end,
}

vim.cmd.colorscheme 'dracula'

require('telescope').load_extension 'notify'
vim.notify = require 'notify'
