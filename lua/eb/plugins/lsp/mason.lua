--  _ __ ___   __ _ ___  ___  _ __
-- | '_ ` _ \ / _` / __|/ _ \| '_ \
-- | | | | | | (_| \__ \ (_) | | | |
-- |_| |_| |_|\__,_|___/\___/|_| |_|
-- https://github.com/williamboman/mason.nvim

return {
    "williamboman/mason.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason-lspconfig.nvim", -- https://github.com/williamboman/mason-lspconfig.nvim
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },

    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        -- NOTE: setup calls required for both mason & mason-lspconfig
        -- Source: https://github.com/williamboman/mason-lspconfig.nvim#setup

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            -- NOTE: this section makes sure the below languages are available during first install when running :LSPInstall
            ensure_installed = {
                "vimls",
                "bashls",
                "pyright",
                "lua_ls",
                "ansiblels",
                "jsonls",
                "sqlls",
                "emmet_ls",
                "tsserver",
                "tailwindcss",
                "gopls",
                "taplo",
            },
            automatic_installation = true,
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "prettier", -- prettier formatter
                "stylua", -- lua formatter
                "black", -- python formatter
                "pylint",
                "goimports",
                "shellcheck",
                "pylint",
                "ansible-lint",
                "eslint_d",
                "markdownlint",
            },
        })
    end,
}
