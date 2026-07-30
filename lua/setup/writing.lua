local window_options = {
  'breakindent',
  'colorcolumn',
  'cursorline',
  'foldcolumn',
  'linebreak',
  'list',
  'number',
  'relativenumber',
  'showbreak',
  'signcolumn',
  'spell',
  'wrap',
}

local buffer_options = {
  'spelllang',
  'textwidth',
}

local function read_options(names, scope)
  local values = {}

  for _, name in ipairs(names) do
    values[name] = vim.api.nvim_get_option_value(name, scope)
  end

  return values
end

local function write_options(values, scope)
  for name, value in pairs(values) do
    vim.api.nvim_set_option_value(name, value, scope)
  end
end

return {
  'junegunn/goyo.vim',
  cmd = { 'Goyo', 'BookMode' },
  keys = {
    { '<leader>wb', '<cmd>BookMode<CR>', desc = '[W]riting [B]ook mode' },
  },
  dependencies = {
    {
      'rebelot/kanagawa.nvim',
      opts = {
        transparent = false,
        theme = 'dragon',
      },
    },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
      opts = {
        enabled = false,
        render_modes = { 'n', 'c', 't' },
      },
    },
  },
  init = function()
    vim.g.goyo_width = 90
    vim.g.goyo_linenr = 0
  end,
  config = function()
    local active_state
    local pending_state

    local function capture_state()
      local bufnr = vim.api.nvim_get_current_buf()
      local winid = vim.api.nvim_get_current_win()

      return {
        background = vim.o.background,
        buffer_options = read_options(buffer_options, { buf = bufnr }),
        bufnr = bufnr,
        colorscheme = vim.g.colors_name,
        diagnostics = vim.diagnostic.is_enabled { bufnr = bufnr },
        filetype = vim.bo[bufnr].filetype,
        window_options = read_options(window_options, { win = winid }),
        winid = winid,
      }
    end

    local function render_markdown(enable, bufnr)
      if vim.bo[bufnr].filetype ~= 'markdown' then
        return
      end

      local ok, renderer = pcall(require, 'render-markdown')
      if not ok then
        return
      end

      if enable then
        renderer.buf_enable()
      else
        renderer.buf_disable()
      end
    end

    local function enter_book_mode()
      if not pending_state then
        return
      end

      active_state = pending_state
      pending_state = nil

      local bufnr = active_state.bufnr
      local winid = vim.api.nvim_get_current_win()
      active_state.book_winid = winid

      write_options({
        breakindent = true,
        colorcolumn = '',
        cursorline = false,
        foldcolumn = '0',
        linebreak = true,
        list = false,
        number = false,
        relativenumber = false,
        showbreak = '',
        signcolumn = 'no',
        spell = true,
        wrap = true,
      }, { win = winid })

      write_options({
        spelllang = 'en_us',
        textwidth = 0,
      }, { buf = bufnr })

      vim.diagnostic.enable(false, { bufnr = bufnr })
      vim.o.background = 'dark'
      vim.cmd.colorscheme 'kanagawa-dragon'

      vim.b[bufnr].book_mode = true
      render_markdown(true, bufnr)
      vim.o.laststatus = 3
      require('lualine').refresh {
        force = true,
        scope = 'window',
        place = { 'statusline' },
      }
    end

    local function leave_book_mode()
      if not active_state then
        return
      end

      local saved = active_state
      active_state = nil
      pending_state = nil

      if vim.api.nvim_buf_is_valid(saved.bufnr) then
        render_markdown(false, saved.bufnr)
        write_options(saved.buffer_options, { buf = saved.bufnr })
        vim.diagnostic.enable(saved.diagnostics, { bufnr = saved.bufnr })
        vim.b[saved.bufnr].book_mode = false
      end

      vim.o.background = saved.background
      if saved.colorscheme then
        vim.cmd.colorscheme(saved.colorscheme)
      end

      if vim.api.nvim_win_is_valid(saved.winid) then
        write_options(saved.window_options, { win = saved.winid })
      end
    end

    local writing_group = vim.api.nvim_create_augroup('BookMode', { clear = true })
    vim.api.nvim_create_autocmd('User', {
      group = writing_group,
      pattern = 'GoyoEnter',
      callback = enter_book_mode,
    })
    vim.api.nvim_create_autocmd('User', {
      group = writing_group,
      pattern = 'GoyoLeave',
      callback = leave_book_mode,
    })

    vim.api.nvim_create_user_command('BookMode', function()
      if active_state then
        vim.cmd 'Goyo!'
        return
      end

      if pending_state then
        return
      end

      local filetype = vim.bo.filetype
      if filetype ~= 'markdown' and filetype ~= 'text' then
        vim.notify('Book Mode is available for Markdown and text buffers.', vim.log.levels.WARN)
        return
      end

      pending_state = capture_state()
      local ok, error_message = pcall(vim.cmd, 'Goyo 90')
      if not ok then
        pending_state = nil
        vim.notify(('Unable to enter Book Mode: %s'):format(error_message), vim.log.levels.ERROR)
      end
    end, { desc = 'Toggle distraction-free Book Mode' })
  end,
}
