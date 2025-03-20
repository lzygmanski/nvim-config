return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'b0o/schemastore.nvim',
    'hrsh7th/cmp-nvim-lsp',
  },

  config = function()
    -- Servers
    local schemas = require('schemastore').json.schemas()
    local servers = {
      lua_ls = {
        Lua = {
          telemetry = { enable = false },
          completion = {
            callSnippet = 'Replace',
          },
          diagnostics = {
            disable = { 'missing-fields', 'incomplete-signature-doc' },
            globals = { 'vim', 'hello' },
          },
        },
      },
      jsonls = {
        json = {
          schemas = schemas,
        },
      },
      yamlls = {
        json = {
          schemas = schemas,
        },
      },
      emmet_ls = {},
      dockerls = {},
      bashls = {},
      pyright = {},
      vimls = {},
      html = {},
      cssls = {},
      graphql = {},
      ts_ls = {},
      vuels = {},
      tailwindcss = {},
      eslint = {},
      clangd = {},
      cmake = {},
    }

    -- Mason
    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      -- DAP
      -- Manage by mason-nvim-dap plugin, check below

      -- Linter
      'eslint_d',
      'shellcheck',
      'luacheck',
      'flake8',
      'cspell',

      -- Formatter
      'prettierd',
      'stylua',
      'shfmt',
      'clang-format',
    })

    require('mason-tool-installer').setup {
      ensure_installed = ensure_installed,
      run_on_start = true,
      auto_update = true,
    }

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      ensure_installed = {
        'stylua',
        'python',
        'node2',
        'codelldb',
      },
      handlers = {},
    }

    -- NVIM capabilities setup
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    ---@diagnostic disable-next-line: missing-fields
    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
