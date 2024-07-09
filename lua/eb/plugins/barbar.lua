--  _                _
-- | |__   __ _ _ __| |__   __ _ _ __
-- | '_ \ / _` | '__| '_ \ / _` | '__|
-- | |_) | (_| | |  | |_) | (_| | |
-- |_.__/ \__,_|_|  |_.__/ \__,_|_|
-- https://github.com/romgrk/barbar.nvim

return {
    "romgrk/barbar.nvim",
    event = "VeryLazy",
    dependencies = {
        "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
        { "nvim-tree/nvim-web-devicons", lazy = true }, -- OPTIONAL: for file icons
    },

    config = function()
        local barbar = require("barbar")
        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_normal = custom_helpers.keymap_normal

        -- SETUP
        barbar.setup({
            auto_hide = true,
            animation = true,
            -- closable = false,
            icons = {
                pinned = {
                    button = "",
                },
                button = false,
                current = {
                    button = "",
                },
                gitsigns = {
                    added = { enabled = false, icon = "+" },
                    changed = { enabled = false, icon = "~" },
                    deleted = { enabled = false, icon = "-" },
                },
                preset = "default",
                -- separator = { left = '▎', right = '' },
                separator = { left = "", right = "" },
                separator_at_end = false,
                inactive = {
                    separator = {
                        left = "",
                        right = "",
                    },
                },
            },
            insert_at_end = true,
            minimum_padding = 2,
            maximum_padding = 2,
            sidebar_filetypes = {
                NvimTree = "enabled",
                undotree = { text = "undotree" },
            },
        })

        -- KEYMAPS

        -- NOTE: replacing the below user command with a auto-sessions plugin
        -- This function saves all buffers to a session file located in:
        -- $HOME/.nvim-sessions
        -- The function is called using a keymap_normal defined in the keymap_normal section below.
        -- SOURCE: https://github.com/romgrk/barbar.nvim#custom
        -- to open session type - :source ~/.nvim-sessions/<session name>
        -- vim.opt.sessionoptions:append 'globals'
        -- vim.api.nvim_create_user_command(
        --     'Mksession',
        --     function(attr)
        --         vim.api.nvim_exec_autocmds('User', { pattern = 'SessionSavePre' })
        --         -- Neovim 0.8+
        --         vim.cmd.mksession { bang = attr.bang, args = attr.fargs }
        --     end,
        --     { bang = true, complete = 'file', desc = 'Save barbar with :mksession', nargs = '?' }
        -- )

        -- Navigate between buffers
        keymap_normal("<S-tab>", "<Cmd>BufferPrevious<CR>", "BARBAR", true, "Previous buffer")
        keymap_normal("<tab>", "<Cmd>BufferNext<CR>", "BARBAR", true, "Next buffer")

        -- Re-order buffers
        keymap_normal("<A-<>", "<Cmd>BufferMovePrevious<CR>", "BARBAR", true, "Move buffer to the left")
        keymap_normal("<A->>", "<Cmd>BufferMoveNext<CR>", "BARBAR", true, "Move buffer to the right")

        -- Pin/Unpin buffer
        keymap_normal("<A-p>", "<Cmd>BufferPin<CR>", "BARBAR", true, "Pin buffer")

        -- Close buffer
        keymap_normal("<leader>bd", "<Cmd>BufferClose<CR>", "BARBAR", true, "Close current buffer")

        -- Goto buffer position
        keymap_normal("<A-1>", "<Cmd>BufferGoto 1<CR>", "BARBAR", true, "Go to buffer tab 1")
        keymap_normal("<A-2>", "<Cmd>BufferGoto 2<CR>", "BARBAR", true, "Go to buffer tab 2")
        keymap_normal("<A-3>", "<Cmd>BufferGoto 3<CR>", "BARBAR", true, "Go to buffer tab 3")
        keymap_normal("<A-4>", "<Cmd>BufferGoto 4<CR>", "BARBAR", true, "Go to buffer tab 4")
        keymap_normal("<A-5>", "<Cmd>BufferGoto 5<CR>", "BARBAR", true, "Go to buffer tab 5")
        keymap_normal("<A-6>", "<Cmd>BufferGoto 6<CR>", "BARBAR", true, "Go to buffer tab 6")

        -- keymap_normal('<leader>bs', ':Mksession! ~/.nvim-sessions/', 'Save session')
        -- keymap_normal('<leader>bo', ':source ~/.nvim-sessions/', 'Open session')

        -- TEST:
        -- print('Hello from AFTER/BARBAR')
    end,
}
