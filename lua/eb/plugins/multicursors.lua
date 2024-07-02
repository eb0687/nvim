--                  _ _   _
--  _ __ ___  _   _| | |_(_) ___ _   _ _ __ ___  ___  _ __ ___
-- | '_ ` _ \| | | | | __| |/ __| | | | '__/ __|/ _ \| '__/ __|
-- | | | | | | |_| | | |_| | (__| |_| | |  \__ \ (_) | |  \__ \
-- |_| |_| |_|\__,_|_|\__|_|\___|\__,_|_|  |___/\___/|_|  |___/
-- https://github.com/smoka7/multicursors.nvim

-- lazy.nvim:
return {
    "smoka7/multicursors.nvim",
    dependencies = {
        'smoka7/hydra.nvim',
    },
    opts = {},
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    keys = {
        {
            mode = { 'v', 'n' },
            '<Leader>m',
            '<cmd>MCstart<cr>',
            desc = 'Create a selection for selected text or word under the cursor',
        },
    },

    config = function()
        local multicursors = require('multicursors')

        multicursors.setup {
            DEBUG_MODE = false,
            create_commands = true, -- create Multicursor user commands
            updatetime = 50,        -- selections get updated if this many milliseconds nothing is typed in the insert mode see :help updatetime
            nowait = true,          -- see :help :map-nowait
            mode_keys = {
                append = 'a',
                change = 'c',
                extend = 'e',
                insert = 'i',
            }, -- set bindings to start these modes
            -- normal_keys = normal_keys,
            -- insert_keys = insert_keys,
            -- extend_keys = extend_keys,
            -- see :help hydra-config.hint
            hint_config = {
                border = 'none',
                position = 'bottom',
            },

            -- accepted values:
            -- -1 true: generate hints
            -- -2 false: don't generate hints
            -- -3 [[multi line string]] provide your own hints
            generate_hints = {
                normal = false,
                insert = false,
                extend = false,
            },

        }
    end
}
