--  _                _
-- | |__   __ _ _ __| |__   __ _ _ __
-- | '_ \ / _` | '__| '_ \ / _` | '__|
-- | |_) | (_| | |  | |_) | (_| | |
-- |_.__/ \__,_|_|  |_.__/ \__,_|_|
-- https://github.com/romgrk/barbar.nvim

return {
    'romgrk/barbar.nvim',
    dependencies = {
        'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },

    config = function()
        local barbar = require("barbar")

        -- SETUP
        barbar.setup({
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
                    added = { enabled = false, icon = '+' },
                    changed = { enabled = false, icon = '~' },
                    deleted = { enabled = false, icon = '-' }
                },
                preset = 'default',
                separator = { left = '▎', right = '' },
                separator_at_end = true,
            },
            insert_at_end = true,
            minimum_padding = 2,
            maximum_padding = 2,
            sidebar_filetypes = {
                NvimTree = 'enabled',
                undotree = { text = 'undotree' },
            }

        })

        -- KEYMAPS

        -- This function saves all buffers to a session file located in:
        -- $HOME/.nvim-sessions
        -- The function is called using a keymap defined in the keymap section below.
        -- SOURCE: https://github.com/romgrk/barbar.nvim#custom
        -- to open session type - :source ~/.nvim-sessions/<session name>
        vim.opt.sessionoptions:append 'globals'
        vim.api.nvim_create_user_command(
            'Mksession',
            function(attr)
                vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' })
                -- Neovim 0.8+
                vim.cmd.mksession { bang = attr.bang, args = attr.fargs }
            end,
            { bang = true, complete = 'file', desc = 'Save barbar with :mksession', nargs = '?' }
        )

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

        -- Goto buffer position
        keymap("<A-1>", "<Cmd>BufferGoto 1<CR>", "Go to buffer tab 1")
        keymap("<A-2>", "<Cmd>BufferGoto 2<CR>", "Go to buffer tab 2")
        keymap("<A-3>", "<Cmd>BufferGoto 3<CR>", "Go to buffer tab 3")
        keymap("<A-4>", "<Cmd>BufferGoto 4<CR>", "Go to buffer tab 4")
        keymap("<A-5>", "<Cmd>BufferGoto 5<CR>", "Go to buffer tab 5")
        keymap("<A-6>", "<Cmd>BufferGoto 6<CR>", "Go to buffer tab 6")

        keymap("<leader>bs", ":Mksession! ~/.nvim-sessions/", "Save session")

        -- TEST:
        print('Hello from AFTER/BARBAR')
    end
}
