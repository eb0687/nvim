-- mini-animate.nvim
-- https://github.com/echasnovski/mini.animate

return {
    "echasnovski/mini.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
        -- NOTE: disabling for now, the reactiveness isnt upto what I like it yet
        -- local animate = require("mini.animate")
        -- animate.setup({
        --     cursor = {
        --         enable = true,
        --         timing = animate.gen_timing.exponential({ duration = 80, unit = "total" }),
        --         path = animate.gen_path.angle({
        --             predicate = function()
        --                 return true
        --             end,
        --         }),
        --     },
        --     resize = {
        --         enable = false,
        --         timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
        --     },
        --     scroll = {
        --         enable = false,
        --     },
        --     open = {
        --         enable = false,
        --         -- Animate for 400 milliseconds with linear easing
        --         timing = animate.gen_timing.linear({ duration = 300, unit = "total" }),
        --         -- Animate with wiping from nearest edge instead of default static one
        --         winconfig = animate.gen_winconfig.wipe({ direction = "from_edge" }),
        --         -- Make bigger windows more transparent
        --         winblend = animate.gen_winblend.linear({ from = 80, to = 100 }),
        --     },
        --     close = {
        --         enable = false,
        --     },
        -- })

        -- source: https://github.com/echasnovski/mini.ai?tab=readme-ov-file
        local ai = require("mini.ai")
        ai.setup()

        -- source: https://github.com/echasnovski/mini.surround
        local surround = require("mini.surround")
        surround.setup()

        -- source: https://github.com/echasnovski/mini.pairs
        local pairs = require("mini.pairs")
        pairs.setup()

        -- source: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md
        local comment = require("mini.comment")
        comment.setup()

        local move = require("mini.move")
        move.setup({
            -- Module mappings. Use `''` (empty string) to disable one.
            mappings = {
                -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
                left = "<",
                right = ">",
                down = "J",
                up = "K",

                -- Move current line in Normal mode
                line_left = "<Left>",
                line_right = "<Right>",
                line_down = "<Down>",
                line_up = "<Up>",
            },

            -- Options which control moving behavior
            options = {
                -- Automatically reindent selection during linewise vertical move
                reindent_linewise = true,
            },
        })

        local indent = require("mini.indentscope")
        indent.setup({
            -- symbol = "▎",
            symbol = "│ ",
            draw = {
                animation = indent.gen_animation.none(),
            },
        })

        local jump = require("mini.jump")
        jump.setup({})

        local clue = require("mini.clue")
        clue.setup({
            triggers = {
                -- Leader triggers
                { mode = "n", keys = "<Leader>" },
                { mode = "x", keys = "<Leader>" },

                -- Built-in completion
                { mode = "i", keys = "<C-x>" },

                -- `g` key
                { mode = "n", keys = "g" },
                { mode = "x", keys = "g" },

                -- Marks
                { mode = "n", keys = "'" },
                { mode = "n", keys = "`" },
                { mode = "x", keys = "'" },
                { mode = "x", keys = "`" },

                -- Registers
                { mode = "n", keys = '"' },
                { mode = "x", keys = '"' },
                { mode = "i", keys = "<C-r>" },
                { mode = "c", keys = "<C-r>" },

                -- Window commands
                { mode = "n", keys = "<C-w>" },

                -- `z` key
                { mode = "n", keys = "z" },
                { mode = "x", keys = "z" },
            },

            clues = {
                -- Enhance this by adding descriptions for <Leader> mapping groups
                -- clue.gen_clues.builtin_completion(),
                -- clue.gen_clues.g(),
                -- clue.gen_clues.marks(),
                -- clue.gen_clues.registers(),
                -- clue.gen_clues.windows(),
                -- clue.gen_clues.z(),
            },
            window = {
                config = { width = 50 },
            },
        })
        -- TODO: mayb replace colorizer.nvim with the below
        -- source: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-hipatterns.md
    end,
}
