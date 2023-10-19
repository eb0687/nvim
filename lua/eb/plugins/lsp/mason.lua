--  _ __ ___   __ _ ___  ___  _ __
-- | '_ ` _ \ / _` / __|/ _ \| '_ \
-- | | | | | | (_| \__ \ (_) | | | |
-- |_| |_| |_|\__,_|___/\___/|_| |_|
-- https://github.com/williamboman/mason.nvim

return {
    'williamboman/mason.nvim',

    dependencies = {
        'williamboman/mason-lspconfig.nvim', -- https://github.com/williamboman/mason-lspconfig.nvim
    },

    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")

        -- NOTE: setup calls required for both mason & mason-lspconfig
        -- Source: https://github.com/williamboman/mason-lspconfig.nvim#setup

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        mason_lspconfig.setup({
            -- NOTE: this section makes sure the below languages are available during first install when running :LSPInstall
            ensure_installed = {
                'vimls',
                'bashls',
                'pyright',
                'lua_ls',
                'ansiblels',
                'jsonls',
                'html',
                'sqlls',
                -- https://github.com/olrtg/emmet-language-server
                'emmet_language_server',
                'eslint',
                'tsserver',
                -- 'cssls',
                'tailwindcss'
            },
            automatic_installation = true
        })
    end
}
