-- nvim-line.nvim

-- https://github.com/mfussenegger/nvim-lint

return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")
        -- vim.env.ESLINT_D_PPID = vim.fn.getpid()
        lint.linters_by_ft = {
            ansible = { "ansible_lint" },
            bash = { "shellcheck" },
            python = { "pylint" },
            html = { "markuplint" },
            -- javascript = { "eslint_d" },
            -- typescript = { "eslint_d" },
            markdown = { "markdownlint" },
        }

        local ns = require("lint").get_namespace("markdownlint")
        vim.diagnostic.config({
            virtual_text = false,
            float = {
                show_header = true,
                border = "rounded",
                focusable = true,
            },
        }, ns)

        -- NOTE: dsiable line length warning in markdown files
        -- SOURCE: https://www.reddit.com/r/neovim/comments/19ceuoq/comment/kuna12d/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
        local markdownlint = require("lint").linters.markdownlint
        markdownlint.args = {
            "--disable",
            "MD013",
            "MD007",
            "--", -- Required
        }

        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}
