return {
  'catppuccin/nvim',
  name = 'catppuccin',
  config = function()
    require('catppuccin').setup {
      flavour = 'frappe',
      transparent_background = true,
    }

    vim.cmd.colorscheme 'catppuccin'
  end,
}
-- return {
--   'Mofiqul/dracula.nvim',
--   name = 'dracula',
--   init = function()
--     vim.cmd.colorscheme 'dracula'
--   end,
--   config = function()
--     require('dracula').setup {
--       show_end_of_buffer = true,
--       transparent_bg = true,
--       italic_comment = true,
--       overrides = function(colors)
--         return {
--           TelescopeNormal = { fg = colors.fg, bg = 'none' },
--           NvimTreeNormalFloat = { fg = colors.fg, bg = 'none' },
--           Pmenu = { fg = colors.white, bg = 'none' },
--           PmenuSbar = { bg = 'none' },
--         }
--       end,
--     }
--   end,
-- }
