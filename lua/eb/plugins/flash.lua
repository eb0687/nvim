--   __ _           _
--  / _| | __ _ ___| |__
-- | |_| |/ _` / __| '_ \
-- |  _| | (_| \__ \ | | |
-- |_| |_|\__,_|___/_| |_|
-- https://github.com/folke/flash.nvim

return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "s",
                mode = { "n", "o", "x" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            -- { "r",mode = "o",function() require("flash").remote() end,desc = "Remote Flash" },
            -- { "R",mode = { "Toggle Flash Search", "x" },function() require("flash").treesitter_search() end,desc = "Treesitter Search" },
            -- { "<c-d>", mode = { "c" },function() require("flash").toggle() end,desc = "Toggle Flash Search" },
        },
        config = function()
            require("flash").setup({
                modes = {
                    char = {
                        enabled = true,
                        jump_labels = true,
                    },
                },
            })
        end,
    },
}
