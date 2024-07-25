-- mini-animate.nvim
-- https://github.com/echasnovski/mini.animate

return {
    "echasnovski/mini.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
        local animate = require("mini.animate")
        animate.setup({
            cursor = {
                enable = true,
                timing = animate.gen_timing.exponential({ duration = 80, unit = "total" }),
                path = animate.gen_path.angle({
                    predicate = function()
                        return true
                    end,
                }),
            },
            resize = {
                timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
            },
            scroll = {
                enable = false,
            },
            open = {
                enable = false,
            },
            close = {
                enable = false,
            },
        })
    end,
}
