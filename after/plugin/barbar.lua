-- SOURCE: https://github.com/romgrk/barbar.nvim#lua-1
-- Barbar options

-- TODO: create a pcall for this plugin

-- SETUP [[[

require 'bufferline'.setup {
    autohide = true,
    animation = false,
    closable = false,
    icon_separator_active = '',
    icon_separator_inactive = '',
    icon_pinned = '',
    insert_at_end = true
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
