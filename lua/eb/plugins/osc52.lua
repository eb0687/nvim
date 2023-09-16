--                 ____ ____
--   ___  ___  ___| ___|___ \
--  / _ \/ __|/ __|___ \ __) |
-- | (_) \__ \ (__ ___) / __/
--  \___/|___/\___|____/_____|
-- https://github.com/ojroques/nvim-osc52

return {

    'ojroques/nvim-osc52',
    config = function()
        -- SETUP
        require('osc52').setup {
            max_length = 0, -- Maximum length of selection (0 for no limit)
            silent = false, -- Disable message on successful copy
            trim = false,   -- Trim text before copy
        }

        -- KEYMAPS
        local keymap = vim.keymap.set

        keymap('n', '<leader>c', require('osc52').copy_operator, { expr = true })
        keymap('n', '<leader>cc', '<leader>c_', { remap = true })
        keymap('x', '<leader>c', require('osc52').copy_visual)

        -- TEST:
        -- print('Hello from lazy osc52')
    end
}
