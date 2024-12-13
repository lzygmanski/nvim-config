return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  init = function()
    vim.keymap.set('n', '<leader>b', vim.cmd.NvimTreeToggle, { noremap = true, silent = true, desc = 'Nvim tree' })
    vim.cmd 'autocmd FileType LuaTree setlocal nowrap'
  end,
  config = function()
    local api = require 'nvim-tree.api'

    local HEIGHT_RATIO = 0.8
    local WIDTH_RATIO = 0.5

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    local function edit_or_open()
      local node = api.tree.get_node_under_cursor()

      if node.nodes ~= nil then
        api.node.open.edit()
      else
        api.node.open.edit()
        api.tree.close()
      end
    end

    local function my_on_attach(bufnr)
      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      -- custom mappings
      vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts 'Up')
      vim.keymap.set('n', '?', api.tree.toggle_help, opts 'Help')
      vim.keymap.set('n', 'l', edit_or_open, opts 'Edit')
      vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts 'Close')
      vim.keymap.set('n', '<esc>', vim.cmd.NvimTreeToggle, opts 'Close')
    end

    require('nvim-tree').setup {
      update_cwd = false,
      view = {
        number = true,
        relativenumber = true,
        signcolumn = 'yes',
        float = {
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * WIDTH_RATIO
            local window_h = screen_h * HEIGHT_RATIO
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w) / 2
            local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
            return {
              border = 'rounded',
              relative = 'editor',
              row = center_y,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
            }
          end,
        },
        width = function()
          return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
      },
      renderer = {
        highlight_git = true,
        highlight_opened_files = 'icon',
        indent_markers = {
          enable = true,
        },
        icons = {
          git_placement = 'signcolumn',
        },
      },
      update_focused_file = {
        enable = true,
      },
      diagnostics = {
        enable = true,
      },
      filters = {
        dotfiles = false,
      },
      git = {
        ignore = false,
      },
      actions = {
        open_file = {
          resize_window = false,
        },
      },
      on_attach = my_on_attach,
    }
  end,
}
