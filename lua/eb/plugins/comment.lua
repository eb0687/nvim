--   ____                                     _                _
--  / ___|___  _ __ ___  _ __ ___   ___ _ __ | |_   _ ____   _(_)_ __ ___
-- | |   / _ \| '_ ` _ \| '_ ` _ \ / _ \ '_ \| __| | '_ \ \ / / | '_ ` _ \
-- | |__| (_) | | | | | | | | | | |  __/ | | | |_ _| | | \ V /| | | | | | |
--  \____\___/|_| |_| |_|_| |_| |_|\___|_| |_|\__(_)_| |_|\_/ |_|_| |_| |_|
-- https://github.com/numToStr/Comment.nvim
-- NOTE:
-- Possibly replacing commenatry by tpope as it does block based commenting

return {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    config = function()
        local comment = require('Comment')

        comment.setup {
            -- Add a space b/w comment and the line
            padding = true,
            -- Whether the cursor should stay at its position
            sticky = true,
            -- Lines to be ignored while (un)comment
            -- currently ignoring empty lines
            ignore = '^$',

            -- Keymaps:

            ---LHS of toggle mappings in NORMAL mode
            toggler = {
                line = 'gcc',
                block = 'gbc'
            },

            ---LHS of operator-pending mappings in NORMAL and VISUAL mode
            opleader = {
                line = 'gc',
                block = 'gb'
            },

            ---LHS of extra mappings
            extra = {
                ---Add comment on the line above
                above = 'gcO',
                ---Add comment on the line below
                below = 'gco',
                ---Add comment at the end of line
                eol = 'gcA',
            },

            -- Enable / disable keybindings
            ---NOTE: If given `false` then the plugin won't create any mappings
            mappings = {
                basic = true,
                extra = true
            },

            ---Function to call before (un)comment
            pre_hook = nil,
            ---Function to call after (un)comment
            post_hook = nil,
        }
    end
}
