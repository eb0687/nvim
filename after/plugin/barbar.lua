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
        gitsigns = {
            added = {enabled = false, icon = '+'},
            changed = {enabled = false, icon = '~'},
            deleted = {enabled = false, icon = '-'}
        },
        preset = 'default'
    },
    insert_at_end = true,
    minimum_padding = 2,
    maximum_padding = 2,
}

-- This function saves all buffers to a session file located in:
-- $HOME/.nvim-sessions
-- The function is called using a keymap defined in the keymap section below.
vim.opt.sessionoptions:append 'globals'
vim.api.nvim_create_user_command(
  'Mksession',
  function(attr)
    vim.api.nvim_exec_autocmds('User', {pattern = 'SessionSavePre'})
    -- Neovim 0.8+
    vim.cmd.mksession {bang = attr.bang, args = attr.fargs}
  end,
  {bang = true, complete = 'file', desc = 'Save barbar with :mksession', nargs = '?'}
)

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
