-- OSC52

-- KEYMAPS [[[

-- Variables
local keymap = vim.keymap.set

-- Bindings
keymap('n', '<leader>c', require('osc52').copy_operator, { expr = true })
keymap('n', '<leader>cc', '<leader>c_', { remap = true })
keymap('x', '<leader>c', require('osc52').copy_visual)

-- ]]]

-- TEST:
-- print('Hello from AFTER/OSC52')

