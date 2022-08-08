-- protective call so nothing breaks if lspconfig is missing
local status_ok, _ = pcall(require, "mason-lspconfig")
if not status_ok then
  return
end

-- setup calls required for both mason & mason-lspconfig
-- Source: https://github.com/williamboman/mason-lspconfig.nvim#setup
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup({
    -- makes sure the below languages are available during first install when running :LSPInstall
    ensure_installed = { 'vimls', 'bashls', 'pyright', 'sumneko_lua' }
})
