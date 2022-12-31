-- OSC52

-- TODO: create a pcall for this plugin

-- SETUP [[[

require('osc52').setup {
  max_length = 0,  -- Maximum length of selection (0 for no limit)
  silent = false,  -- Disable message on successful copy
  trim = false,    -- Trim text before copy
}

-- ]]]
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

