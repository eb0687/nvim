-- NULL-LS

-- protective call so nothing breaks if null-ls is missing
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

-- SETUP [[[

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

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
        formatting.mdformat
    }
})

-- ]]]
-- KEYMAPS [[[

-- Variable
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

-- ]]]
