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
    local json_schemas = require('schemastore').json.schemas()
    local yaml_schemas = require('schemastore').yaml.schemas()

    local servers = {
      lua_ls = {
        settings = {
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
      },
      jsonls = {
        settings = {
          json = {
            schemas = json_schemas,
          },
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
      vuels = {},
      tailwindcss = {},
      eslint = {},
      clangd = {},
      cmake = {},
    }

    local mason_managed_servers = vim.tbl_filter(function(server_name)
      return server_name ~= 'pyright'
    end, vim.tbl_keys(servers))

    require('mason').setup {
      PATH = 'prepend',
    }

    local ensure_installed = vim.deepcopy(mason_managed_servers)
    vim.list_extend(ensure_installed, {
      'eslint_d',
      'shellcheck',
      'flake8',
      'cspell',
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

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    for server_name, server in pairs(servers) do
      vim.lsp.config(server_name, vim.tbl_deep_extend('force', {
        capabilities = capabilities,
      }, server))
    end

    require('mason-lspconfig').setup {
      ensure_installed = mason_managed_servers,
      automatic_enable = {
        exclude = { 'ts_ls', 'yamlls', 'pyright' },
      },
    }

    -- NOTE: ts_ls, yamlls, and pyright are intentionally NOT Mason-managed here.
    -- Mason resolves exact package versions from its registry, which can fail on
    -- machines that use a private npm mirror/registry with partial package sync.
    -- Instead, keep the Neovim config portable by attaching these servers when
    -- their executables are already available on PATH (for example via npm -g).
    -- See ./bootstrap-tools.sh for the recommended cross-machine install flow.

    if vim.fn.executable 'typescript-language-server' == 1 then
      vim.lsp.config('ts_ls', {
        capabilities = capabilities,
      })
      vim.lsp.enable 'ts_ls'
    end

    if vim.fn.executable 'yaml-language-server' == 1 then
      vim.lsp.config('yamlls', {
        capabilities = capabilities,
        settings = {
          yaml = {
            schemaStore = {
              enable = false,
              url = '',
            },
            schemas = yaml_schemas,
          },
        },
      })
      vim.lsp.enable 'yamlls'
    end

    if vim.fn.executable 'pyright-langserver' == 1 then
      vim.lsp.enable 'pyright'
    end
  end,
}
