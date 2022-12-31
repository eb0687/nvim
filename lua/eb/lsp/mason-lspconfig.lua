-- LSP CONFIGS

---- 
--local lsp = { 'lspconfig', 'mason-lspconfig'}

---- protective call so nothing breaks if lspconfig is missing
--local status_ok, _ = pcall(require, lsp)
--if not status_ok then
--    return
--end

---- VARIABLES
--local mason_setup = require("mason").setup
--local mason_lsp = require("mason-lspconfig").setup

---- NOTE: setup calls required for both mason & mason-lspconfig
---- Source: https://github.com/williamboman/mason-lspconfig.nvim#setup
--mason_setup({
--    ui = {
--        icons = {
--            package_installed = "✓",
--            package_pending = "➜",
--            package_uninstalled = "✗"
--        }
--    }
--})

--mason_lsp({
--    -- this section makes sure the below languages are available during first install when running :LSPInstall
--    ensure_installed = {
--        'vimls',
--        'bashls',
--        'pyright',
--        'sumneko_lua',
--        'ansiblels',
--    }
--})
