-- conform.nvim
-- https://github.com/stevearc/conform.nvim

return {
    "stevearc/conform.nvim",
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        formatters_by_ft = {
            javascript = { "prettier", "injected" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
            javascriptreact = { "prettier" },
            css = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            lua = { "stylua" },
            python = { "black" },
            go = { "goimports", "gofumpt", "injected" },
            bash = { "beautysh", "shellharden" },
            sql = { "sql_formatter" },
            -- ["*"] = { "injected" },
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

        -- NOTE: does this work?
        -- https://github.com/tjdevries/config.nvim/blob/master/lua/custom/autoformat.lua
        conform.formatters.injected = {
            options = {
                ignore_errors = false,
                lang_to_formatters = {
                    sql = { "sql_formatter" },
                },
            },
        }

        -- BUG: The following keymap does not work
        -- vim.keymap.set({ "n", "v" }, "<leader>fr", function()
        --     conform.format({
        --         lsp_fallback = true,
        --         async = false,
        --         timeout_ms = 1000,
        --     })
        -- end, { desc = "Format file" })
    end,
}
