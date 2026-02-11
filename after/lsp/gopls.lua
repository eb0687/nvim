-- SOURCE: https://github.com/golang/tools/blob/master/gopls/doc/vim.md

return {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    -- root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    root_dir = vim.fs.dirname(vim.fs.find({
        "go.work",
        "go.mod",
        ".git",
    }, { upward = true })[1]),
    settings = {
        gopls = {
            -- SOURCE: https://github.com/chrisgrieser/nvim-lsp-endhints?tab=readme-ov-file#how-to-enable-inlay-hints-for-a-language
            hints = {
                rangeVariableTypes = true,
                parameterNames = true,
                constantValues = true,
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                functionTypeParameters = true,
            },
            completeUnimported = true,
            usePlaceholders = false,
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
        },
    },
}
