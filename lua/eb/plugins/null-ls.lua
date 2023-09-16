-- null-ls
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main
-- NOTE:
-- this project has been archive and no longer being maintained, need to look
-- for an alternative solution. This project still does work for the time being

return {
    'jose-elias-alvarez/null-ls.nvim',

    config = function()
        local null_ls = require("null-ls")
        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics

        -- SETUP
        null_ls.setup({
            debug = false,
            sources = {
                -- formatter for python
                formatting.black,
                -- formatter for bash, zsh & sh
                formatting.beautysh,
                -- prettier install: npm install -g prettier
                formatting.prettier,
                -- diagnostics for python
                diagnostics.flake8,
                -- formatter for markdown
                formatting.mdformat,
                -- formatter for terraform
                formatting.terraform_fmt
            }
        })

        -- KEYMAPS
        local keymap = function(keys, func, desc)
            if desc then
                desc = 'NULL-LS: ' .. desc
            end

            vim.keymap.set('n', keys, func, { desc = desc })
        end

        local format = function()
            vim.lsp.buf.format({ async = true })
        end

        -- Bindings
        keymap("<leader>lf", format, '[L]SP [F]ormat')

        -- TEST:
        -- print("Hello from lazy null-ls")
    end
}
