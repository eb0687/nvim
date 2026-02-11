-- NOTE: i installed lua-ls-server manually and symlinked in to ~/.local/bin
-- SOURCE: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
-- SOURCE: https://github.com/luals/lua-language-server

return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            telemetry = {
                enable = false,
            },
            -- make the language server recognize "vim" global
            diagnostics = {
                globals = { "vim" },
            },
            format = {
                enable = false,
            },
            hint = {
                enable = true,
            },
            completion = {
                callSnippet = "Replace",
                workspaceWord = true,
            },
        },
    },
}
