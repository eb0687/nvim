return {
    "Mathijs-Bakker/godotdev.nvim",
    dependencies = { "nvim-treesitter" },
    branch = "feat/wsl2_path_support",
    config = function()
        local godotdev = require("godotdev")
        godotdev.setup({
            formatter = false,
            treesitter = {
                auto_setup = false,
            },
            docs = {
                renderer = "buffer",
                buffer = {
                    position = "right",
                    size = 0.5,
                },
            },
        })
    end,
}
