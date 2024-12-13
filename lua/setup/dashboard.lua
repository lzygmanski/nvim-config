return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  config = function()
    local split = function(str, character)
      local result = {}
      local index = 1
      for s in string.gmatch(str, character) do
        result[index] = s
        index = index + 1
      end
      return result
    end

    require('dashboard').setup {
      config = {
        header = split(hello, '[^\n]+'),
      },
    }
  end,
}
