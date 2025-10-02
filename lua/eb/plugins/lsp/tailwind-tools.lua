-- https://github.com/luckasRanarison/tailwind-tools.nvim
-- TODO: this is deprecated, need to find an alternative
return {
    "luckasRanarison/tailwind-tools.nvim",
    enabled = true,
    event = "VeryLazy",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "neovim/nvim-lspconfig", -- optional
    },
    opts = {}, -- your configuration
    config = function()
        local tailwind = require("tailwind-tools")
        tailwind.setup({
            server = {
                override = true,
                settings = {},
                capabilities = {},
            },
            -- your configuration
        })
    end,
}
