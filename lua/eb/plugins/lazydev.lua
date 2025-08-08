return {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            -- always load the LazyVim library
            "LazyVim",
            -- Only load the lazyvim library when the `LazyVim` global is found
            { path = "LazyVim", words = { "LazyVim" } },
        },
    },
}
