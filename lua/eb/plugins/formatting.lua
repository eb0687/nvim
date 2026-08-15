-- conform.nvim
-- https://github.com/stevearc/conform.nvim

return {
    "stevearc/conform.nvim",
    ---@module "conform"
    opts = {
        formatters = {
            rustfmt = {
                prepend_args = { "--config", "max_width=80" },
            },
        },
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
            jsonc = { "prettier" },
            lua = { "stylua" },
            python = { "black" },
            go = { "goimports", "gofumpt" },
            bash = { "beautysh", "shellharden" },
            sh = { "beautysh", "shellharden" },
            sql = { "sql_formatter" },
            rust = { "rustfmt" },
            xml = { "xmllint" },
            templ = { "templ" },
            gdscript = { "gdformat" },
            nix = { "nixfmt" },
        },
    },
    config = function(_, opts)
        local conform = require("conform")
        conform.setup(opts)

        -- NOTE: autoformat on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                require("conform").format({ bufnr = args.buf })
            end,
        })
    end,
}
