-- --      __
-- --     / /_  ____  ____
-- --    / __ \/ __ \/ __ \
-- --   / / / / /_/ / /_/ /
-- --  /_/ /_/\____/ .___/
-- --             /_/

-- -- protective call so nothing breaks if hop is missing
-- local status_ok, _ = pcall(require, "hop")
-- if not status_ok then
--     return
-- end

-- -- SETUP [[[

-- require('hop').setup({
--     keys = 'etovxqpdygfblzhckisuran',
--     jump_on_sole_occurrence = true,
-- })

-- -- ]]]
-- -- KEYMAPS [[[

-- -- Variables
-- local keymap = function(keys, func, desc)
--     if desc then
--         desc = 'HOP: ' .. desc
--     end

--     vim.keymap.set('', keys, func, { desc = desc })
-- end

-- local keymap_n = function(keys, func, desc)
--     if desc then
--         desc = 'HOP: ' .. desc
--     end

--     vim.keymap.set('n', keys, func, { desc = desc })
-- end

-- local keymap_v = function(keys, func, desc)
--     if desc then
--         desc = 'HOP: ' .. desc
--     end

--     vim.keymap.set('v', keys, func, { desc = desc })
-- end

-- -- Bindings

-- keymap_n("<leader>hw", ":HopWord<CR>", '[H]op [W]ord')
-- keymap_n("<leader>hl", ":HopLine<CR>", '[H]op [L]ine')
-- keymap_n("<leader>hp", ":HopPattern<CR>", '[H]op [P]attern')
-- keymap_v("<leader>hw", ":HopWord<CR>", '[H]op [W]ord')
-- keymap_v("<leader>hl", ":HopLine<CR>", '[H]op [L]ine')

-- -- Vim-Motions
-- keymap('f', function()
--     require('hop').hint_char1({
--         direction = require('hop.hint').HintDirection.AFTER_CURSOR,
--         current_line_only = true
--     })
-- end, 'Hop forward to character')

-- keymap('F', function()
--     require('hop').hint_char1({
--         direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
--         current_line_only = true,
--     })
-- end, 'Hop backward to character')

-- keymap('t', function()
--     require('hop').hint_char1({
--         direction = require('hop.hint').HintDirection.AFTER_CURSOR,
--         current_line_only = true,
--         hint_offset = -1
--     })
-- end, 'Hop forward to character but place cursor behind character')

-- keymap('T', function()
--     require('hop').hint_char1({
--         direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
--         current_line_only = true,
--         hint_offset = 1
--     })
-- end, 'Hop backward to character but place cursor infront of character')

-- -- ]]]

-- -- TEST:
-- -- print('Hello from AFTER/HOP')
