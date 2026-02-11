-- conform.nvim
-- https://github.com/stevearc/conform.nvim

return {
    "stevearc/conform.nvim",
    ---@module "conform"
    opts = {
        formatters_by_ft = {
            javascript = { "biome", "biome-organize-imports" },
            javascriptreact = { "biome", "biome-organize-imports" },
            typescript = { "biome", "biome-organize-imports" },
            typescriptreact = { "biome", "biome-organize-imports" },
            -- TODO: biome to replace prettier for css, html, json, yaml, markdown
            css = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            lua = { "stylua" },
            python = { "black" },
            go = { "goimports", "gofumpt" },
            bash = { "beautysh", "shellharden" },
            sh = { "beautysh", "shellharden" },
            sql = { "sql_formatter" },
            rust = { "rustfmt" },
            xml = { "xmllint" },
        },
        format_on_save = {
            lsp_format = "fallback",
            async = false,
            timeout_ms = 1000,
        },
    },
    config = function(_, opts)
        local conform = require("conform")
        conform.setup(opts)
    end,
}
