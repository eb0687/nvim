--  _
-- | |__   ___  _ __
-- | '_ \ / _ \| '_ \
-- | | | | (_) | |_) |
-- |_| |_|\___/| .__/
--             |_|
-- https://github.com/smoka7/hop.nvim

return {
    "smoka7/hop.nvim",
    version = "*",
    enabled = false,

    config = function()
        local hop = require("hop")
        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_normal = custom_helpers.keymap_normal
        local keymap_visual = custom_helpers.keymap_visual
        local keymap = custom_helpers.keymap

        -- SETUP
        -- source: https://github.com/smoka7/hop.nvim/wiki/Configuration
        hop.setup({
            keys = "etovxqpdygfblzhckisuran",
            jump_on_sole_occurrence = false,
        })

        -- source: https://github.com/smoka7/hop.nvim/wiki/Commands
        keymap_normal("<leader>hw", ":HopWord<CR", "HOP", true, "[H]op [W]ord")
        keymap_normal("<leader>hl", ":HopLine<CR", "HOP", true, "[H]op [L]ine")
        keymap_normal("<leader>hp", ":HopPattern<CR", "HOP", true, "[H]op [P]attern")
        keymap_visual("<leader>hw", ":HopWord<CR", "HOP", true, "[H]op [W]ord")
        keymap_visual("<leader>hl", ":HopLine<CR", "HOP", true, "[H]op [L]ine")

        -- VIM MOTIONS
        keymap("f", function()
            require("hop").hint_char1({
                direction = require("hop.hint").HintDirection.AFTER_CURSOR,
                current_line_only = true,
            })
        end, "HOP", true, "Hop forward to character")

        keymap("F", function()
            require("hop").hint_char1({
                direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
                current_line_only = true,
            })
        end, "HOP", true, "Hop backward to character")

        keymap("t", function()
            require("hop").hint_char1({
                direction = require("hop.hint").HintDirection.AFTER_CURSOR,
                current_line_only = true,
                hint_offset = -1,
            })
        end, "HOP", true, "Hop forward to character but place cursor behind character")

        keymap("T", function()
            require("hop").hint_char1({
                direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
                current_line_only = true,
                hint_offset = 1,
            })
        end, "HOP", true, "Hop backward to character but place cursor infront of character")

        -- TEST:
        -- print('Hello from lazy hop')
    end,
}
