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
                enable = false,
                timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
            },
            scroll = {
                enable = false,
            },
            open = {
                enable = false,
                -- Animate for 400 milliseconds with linear easing
                timing = animate.gen_timing.linear({ duration = 300, unit = "total" }),

                -- Animate with wiping from nearest edge instead of default static one
                winconfig = animate.gen_winconfig.wipe({ direction = "from_edge" }),

                -- Make bigger windows more transparent
                winblend = animate.gen_winblend.linear({ from = 80, to = 100 }),
            },
            close = {
                enable = false,
            },
        })
    end,
}
