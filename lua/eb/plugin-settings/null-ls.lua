-- protective call so nothing breaks if null-ls is missing
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

-- setup
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
