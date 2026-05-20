return {
  'mfussenegger/nvim-lint',
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      python = { 'flake8' },
      sh = { 'shellcheck' },
      bash = { 'shellcheck' },
      zsh = { 'shellcheck' },
    }

    local warned = {}

    local function available_linters(bufnr)
      local ft = vim.bo[bufnr].filetype
      local linters = lint.linters_by_ft[ft] or {}
      local available = {}

      for _, name in ipairs(linters) do
        local linter = lint.linters[name]
        local cmd = linter and linter.cmd
        if type(cmd) == 'function' then
          cmd = cmd()
        end

        if type(cmd) == 'string' and vim.fn.executable(cmd) == 1 then
          table.insert(available, name)
        elseif not warned[name] then
          warned[name] = true
          vim.schedule(function()
            vim.notify(('nvim-lint: skipping %s (executable not found)'):format(name), vim.log.levels.WARN)
          end)
        end
      end

      return available
    end

    local lint_augroup = vim.api.nvim_create_augroup('LintGroup', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
      group = lint_augroup,
      callback = function(args)
        local names = available_linters(args.buf)
        if #names > 0 then
          lint.try_lint(names)
        end
      end,
    })
  end,
}
