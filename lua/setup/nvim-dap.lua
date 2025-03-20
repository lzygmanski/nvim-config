return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    dapui.setup()

    ---@diagnostic disable-next-line: missing-fields
    require('nvim-dap-virtual-text').setup {
      commented = true,
    }

    vim.keymap.set('n', '<leader>xc', dap.continue, { desc = '[DAP] Continue' })
    vim.keymap.set('n', '<leader>xo', dap.step_over, { desc = '[DAP] Step Over' })
    vim.keymap.set('n', '<leader>xi', dap.step_into, { desc = '[DAP] Step Into' })
    vim.keymap.set('n', '<leader>xu', dap.step_out, { desc = '[DAP] Step Out' })

    vim.keymap.set('n', '<leader>xb', dap.toggle_breakpoint, { desc = '[DAP] Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>xB', dap.set_breakpoint, { desc = '[DAP] Set Breakpoint' })
    vim.keymap.set('n', '<leader>xlp', function()
      dap.set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
    end, { desc = '[DAP] Set Log Point' })

    vim.keymap.set('n', '<leader>xr', dap.repl.open, { desc = '[DAP] Open REPL' })
    vim.keymap.set('n', '<leader>xl', dap.run_last, { desc = '[DAP] Run Last' })

    vim.keymap.set({ 'n', 'v' }, '<leader>xp', require('dap.ui.widgets').preview, { desc = '[DAP] Preview' })

    vim.keymap.set('n', '<leader>xf', function()
      require('dap.ui.widgets').centered_float(require('dap.ui.widgets').frames)
    end, { desc = '[DAP] Show Frames' })

    vim.keymap.set('n', '<leader>xs', function()
      require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes)
    end, { desc = '[DAP] Show Scopes' })

    vim.keymap.set({ 'n', 'v' }, '<leader>xv', function()
      dapui.eval()
    end, { desc = '[DAP] Evaluate Variables' })

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DiagnosticSignWarn', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
    vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DiagnosticSignInfo', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '', texthl = 'DiagnosticSignWarn', linehl = 'Visual', numhl = '' })
  end,
}
