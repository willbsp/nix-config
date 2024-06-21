-- [[ LSP ]] --

require('fidget').setup {}
require('neodev').setup { -- Must be setup before lspconfig
  override = function(root_dir, library)
    if root_dir:find('/etc/nixos', 1, true) == 1 then
      library.enabled = true
      library.plugins = true
    end
  end,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

local lspconfig = require 'lspconfig'
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
  capabilities = capabilities,
}

lspconfig.nil_ls.setup {
  settings = { -- nix language server
    ['nil'] = {
      formatting = {
        command = { 'nixpkgs-fmt' },
      },
    },
  },
  capabilities = capabilities,
}

lspconfig.arduino_language_server.setup {}
