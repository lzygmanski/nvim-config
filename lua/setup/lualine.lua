return {
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      component_separators = '·',
      section_separators = '',
    },
    sections = {
      lualine_x = {
        function()
          if not vim.b.book_mode then
            return ''
          end

          return ('%d words'):format(vim.fn.wordcount().words)
        end,
        'encoding',
        'fileformat',
        'filetype',
      },
    },
  },
}
