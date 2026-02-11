-- NOTE: bashls integrates shellcheck by default
-- SOURCE: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
-- SOURCE: https://github.com/bash-lsp/bash-language-server

return {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "bash" },
}
