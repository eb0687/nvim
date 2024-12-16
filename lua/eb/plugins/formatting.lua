-- conform.nvim
-- https://github.com/stevearc/conform.nvim

return {
    "stevearc/conform.nvim",
    -- event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                javascript = { "prettier", "injected" },
                typescript = { "prettier" },
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
            -- format_on_save = {
            --     lsp_format = "fallback",
            --     async = false,
            --     timeout_ms = 1000,
            -- },
        })

        -- require("conform").formatters.sql_formatter = {
        --     prepend_args = { "-c", vim.fn.expand("~/.config/sql_formatter.json") },
        -- }

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
