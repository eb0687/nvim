--  _
-- | |__   ___  _ __
-- | '_ \ / _ \| '_ \
-- | | | | (_) | |_) |
-- |_| |_|\___/| .__/
--             |_|
-- https://github.com/smoka7/hop.nvim

return {
    'smoka7/hop.nvim',
    version = "*",

    config = function()
        local hop = require('hop')

        -- SETUP
        -- source: https://github.com/smoka7/hop.nvim/wiki/Configuration
        hop.setup({
            keys = 'etovxqpdygfblzhckisuran',
            jump_on_sole_occurrence = false,
        })

        -- KEYMAPS
        local keymap = function(keys, func, desc)
            if desc then
                desc = 'HOP: ' .. desc
            end

            vim.keymap.set('', keys, func, { desc = desc })
        end

        local keymap_n = function(keys, func, desc)
            if desc then
                desc = 'HOP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { desc = desc })
        end

        local keymap_v = function(keys, func, desc)
            if desc then
                desc = 'HOP: ' .. desc
            end

            vim.keymap.set('v', keys, func, { desc = desc })
        end

        -- source: https://github.com/smoka7/hop.nvim/wiki/Commands
        keymap_n("<leader>hw", ":HopWord<CR>", '[H]op [W]ord')
        keymap_n("<leader>hl", ":HopLine<CR>", '[H]op [L]ine')
        keymap_n("<leader>hp", ":HopPattern<CR>", '[H]op [P]attern')
        keymap_v("<leader>hw", ":HopWord<CR>", '[H]op [W]ord')
        keymap_v("<leader>hl", ":HopLine<CR>", '[H]op [L]ine')

        -- VIM MOTIONS
        keymap('f', function()
            require('hop').hint_char1({
                direction = require('hop.hint').HintDirection.AFTER_CURSOR,
                current_line_only = true
            })
        end, 'Hop forward to character')

        keymap('F', function()
            require('hop').hint_char1({
                direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
                current_line_only = true,
            })
        end, 'Hop backward to character')

        keymap('t', function()
            require('hop').hint_char1({
                direction = require('hop.hint').HintDirection.AFTER_CURSOR,
                current_line_only = true,
                hint_offset = -1
            })
        end, 'Hop forward to character but place cursor behind character')

        keymap('T', function()
            require('hop').hint_char1({
                direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
                current_line_only = true,
                hint_offset = 1
            })
        end, 'Hop backward to character but place cursor infront of character')

        -- TEST:
        -- print('Hello from lazy hop')
    end
}
