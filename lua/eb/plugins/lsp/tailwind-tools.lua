-- https://github.com/luckasRanarison/tailwind-tools.nvim
return {
    "luckasRanarison/tailwind-tools.nvim",
    event = "VeryLazy",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim", -- optional
        "neovim/nvim-lspconfig", -- optional
    },
    opts = {}, -- your configuration
    config = function()
        local tailwind = require("tailwind-tools")
        tailwind.setup({
            -- your configuration
        })
    end,
}
