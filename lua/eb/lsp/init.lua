-- protective call so nothing breaks if lspconfig is missing
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

-- Source: https://github.com/williamboman/mason.nvim/issues/124#issuecomment-1203211832
-- NOTE: make sure mason-lspconfig is setup before lsp servers are setup

require('eb.lsp.mason-lspconfig')
require('eb.lsp.configs')
