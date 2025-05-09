-- https://github.com/folke/lazydev.nvim
-- FIX: lazydev was breaking completion

return {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    "folke/lazydev.nvim",
    enabled = false,
    ft = "lua",
    opts = {
        library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
    },
}
