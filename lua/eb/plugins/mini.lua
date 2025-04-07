-- mini-animate.nvim
-- https://github.com/echasnovski/mini.animate

return {
    "echasnovski/mini.nvim",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    version = "*",
    event = "VeryLazy",
    config = function()
        -- source: https://github.com/echasnovski/mini.ai?tab=readme-ov-file
        local gen_ai_spec = require("mini.extra").gen_ai_spec
        local ai = require("mini.ai")
        ai.setup({
            custom_textobjects = {
                B = gen_ai_spec.buffer(),
                D = gen_ai_spec.diagnostic(),
                I = gen_ai_spec.indent(),
                L = gen_ai_spec.line(),
                N = gen_ai_spec.number(),
            },
        })

        -- source: https://github.com/echasnovski/mini.surround
        local surround = require("mini.surround")
        surround.setup()

        -- source: https://github.com/echasnovski/mini.pairs
        local pairs = require("mini.pairs")
        pairs.setup()

        -- source: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md
        local comment = require("mini.comment")
        comment.setup({
            options = {
                custom_commentstring = function()
                    return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
                end,
            },
        })

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
                line_left = "<M-Left>",
                line_right = "<M-Right>",
                line_down = "<M-Down>",
                line_up = "<M-Up>",
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

        -- source: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-hipatterns.md
        -- NOTE: look at the examples for custom setup similar to todo-comments
        local hipatterns = require("mini.hipatterns")
        hipatterns.setup({
            highlighters = {
                hex_color = hipatterns.gen_highlighter.hex_color(),
            },
        })

        -- source: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-splitjoin.md
        local splitjoin = require("mini.splitjoin")
        splitjoin.setup({})

        -- source: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-cursorword.md
        local cursorword = require("mini.cursorword")
        cursorword.setup({ delay = 50 })

        -- Miscellaneous
        require("mini.misc").setup({})
        require("mini.misc").setup_restore_cursor()

        local custom_helpers = require("lua.eb.utils.custom_helpers")
        local keymap_silent = custom_helpers.keymap_silent

        keymap_silent("n", "<leader>=", function()
            MiniMisc.zoom()
        end, "MINI: Zoom in/out buffer")

        -- FIX: disabled for now due to conflicts with keybinds
        -- local operators = require("mini.operators")
        -- operators.setup({})
    end,
}
