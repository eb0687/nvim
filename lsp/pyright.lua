-- SOURCE: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright
-- SOURCE: https://github.com/microsoft/pyright

return {
    settings = {
        pyright = {
            disableOrganizeImports = false,
            analysis = {
                useLibraryCodeForTypes = true,
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                autoImportCompletions = true,
            },
        },
    },
}
