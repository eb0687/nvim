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
        -- MINI AI
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

        -- MINI SURROUND
        -- source: https://github.com/echasnovski/mini.surround
        local surround = require("mini.surround")
        surround.setup({
            highlight_duration = 200,
            mappings = {
                add = "gsa", -- Add surrounding in Normal and Visual modes
                delete = "gsd", -- Delete surrounding
                find = "gsf", -- Find surrounding (to the right)
                find_left = "gsF", -- Find surrounding (to the left)
                highlight = "gsh", -- Highlight surrounding
                replace = "gsr", -- Replace surrounding
                update_n_lines = "gsn", -- Update `n_lines`

                suffix_last = "l", -- Suffix to search with "prev" method
                suffix_next = "n", -- Suffix to search with "next" method
            },
        })

        -- MINI PAIRS
        -- source: https://github.com/echasnovski/mini.pairs
        local pairs = require("mini.pairs")
        pairs.setup()

        -- MINI COMMENT
        -- source: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md
        local comment = require("mini.comment")
        comment.setup({
            options = {
                custom_commentstring = function()
                    return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
                end,
            },
        })

        -- MINI MOVE
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

        -- MINI INDENTSCOPE
        local indent = require("mini.indentscope")
        indent.setup({
            -- symbol = "▎",
            symbol = "│ ",
            draw = {
                animation = indent.gen_animation.none(),
            },
        })

        -- MINI CLUE
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

        -- MINI HI-PATTERNS
        -- source: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-hipatterns.md
        -- NOTE: look at the examples for custom setup similar to todo-comments
        local hipatterns = require("mini.hipatterns")
        hipatterns.setup({
            highlighters = {
                hex_color = hipatterns.gen_highlighter.hex_color(),
            },
        })

        -- MINI SPLIT-JOIN
        -- source: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-splitjoin.md
        local splitjoin = require("mini.splitjoin")
        splitjoin.setup({})

        -- MINI CURSORWORD
        -- source: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-cursorword.md
        local cursorword = require("mini.cursorword")
        -- cursorword.setup({ delay = 50 })
        cursorword.setup()

        -- MINI MISC
        require("mini.misc").setup({})
        require("mini.misc").setup_restore_cursor()

        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_silent = custom_helpers.keymap_silent

        keymap_silent("n", "<leader>=", function()
            MiniMisc.zoom()
        end, "MINI: Zoom in/out buffer")

        -- MINI KEYMAP
        -- source: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-keymap.md
        local notify_many_keys = function(key)
            local lhs = string.rep(key, 5)
            local action = function()
                vim.notify("Too many " .. key)
            end
            require("mini.keymap").map_combo({ "n", "x" }, lhs, action)
        end
        notify_many_keys("h")
        notify_many_keys("j")
        notify_many_keys("k")
        notify_many_keys("l")

        local map_combo = require("mini.keymap").map_combo
        -- Support most common modes. This can also contain 't', but would
        -- only mean to press `<Esc>` inside terminal.
        local mode = { "i", "c", "x", "s" }
        map_combo(mode, "jk", "<BS><BS><Esc>")
        -- To not have to worry about the order of keys, also map "kj"
        map_combo(mode, "kj", "<BS><BS><Esc>")
        -- Escape into Normal mode from Terminal mode
        map_combo("t", "jk", "<BS><BS><C-\\><C-n>")
        map_combo("t", "kj", "<BS><BS><C-\\><C-n>")
    end,
}
