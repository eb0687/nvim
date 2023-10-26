-- null-ls
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main
-- NOTE:
-- this project has been archive and no longer being maintained, need to look
-- for an alternative solution. This project still does work for the time being

-- NOTE: using a fork of the null-ls project maintained by the community
-- https://github.com/nvimtools/none-ls.nvim

return {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },

    config = function()
        local null_ls = require("null-ls")
        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics
        -- local hover = null_ls.builtins.hover
        -- local code_actions = null_ls.builtins.code_actions
        -- local completion = null_ls.builtins.completion

        local sources = {
            formatting.black,
            formatting.beautysh,
            formatting.prettier,
            -- formatting.stylua,
            formatting.mdformat,
            diagnostics.flake8,
            diagnostics.markuplint,
            -- diagnostics.luacheck,
            -- diagnostics.eslint,
            -- completion.luasnip,
        }

        -- SETUP
        null_ls.setup({
            debug = false,
            sources = sources,
        })

        -- KEYMAPS
        local keymap = function(keys, func, desc)
            if desc then
                desc = "NULL-LS: " .. desc
            end

            vim.keymap.set("n", keys, func, { desc = desc })
        end

        local format = function()
            vim.lsp.buf.format({ async = true })
        end

        -- Bindings
        keymap("<leader>lf", format, "[L]SP [F]ormat")

        -- TEST:
        -- print("Hello from lazy null-ls")
    end,
}
