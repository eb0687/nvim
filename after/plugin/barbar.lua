-- SOURCE: https://github.com/romgrk/barbar.nvim#lua-1
-- Barbar options

-- TODO: create a pcall for this plugin

-- SETUP [[[

require 'bufferline'.setup {
    auto_hide = true,
    animation = true,
    -- closable = false,
    icons = {
        pinned = {
            button = '',
        },
        button = false,
        current = {
            button = ''
        },
    },
    insert_at_end = true,
    minimum_padding = 2,
    maximum_padding = 2,
}

-- ]]]
-- KEYMAPS [[[

-- Variables
local keymap = function(keys, func, desc)
    if desc then
        desc = 'BARBAR: ' .. desc
    end

    vim.keymap.set('n', keys, func, { desc = desc })
end

-- Navigate between buffers
keymap("<S-tab>", "<Cmd>BufferPrevious<CR>", 'Previous buffer')
keymap("<tab>", "<Cmd>BufferNext<CR>", 'Next buffer')

-- Re-order buffers
keymap("<A-<>", "<Cmd>BufferMovePrevious<CR>", 'Move buffer to the left')
keymap("<A->>", "<Cmd>BufferMoveNext<CR>", 'Move buffer to the right')

-- Pin/Unpin buffer
keymap("<A-p>", "<Cmd>BufferPin<CR>", 'Pin buffer')

-- Close buffer
keymap("<leader>bd", "<Cmd>BufferClose<CR>", 'Close current buffer')

-- ]]]

-- TEST:
-- print('Hello from AFTER/BARBAR')
