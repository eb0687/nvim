--  _        _
-- | |_ __ _| |__  ___  __   _____   ___ _ __   __ _  ___ ___  ___
-- | __/ _` | '_ \/ __| \ \ / / __| / __| '_ \ / _` |/ __/ _ \/ __|
-- | || (_| | |_) \__ \  \ V /\__ \ \__ \ |_) | (_| | (_|  __/\__ \
--  \__\__,_|_.__/|___/   \_/ |___/ |___/ .__/ \__,_|\___\___||___/
--                                      |_|
-- https://github.com/tenxsoydev/tabs-vs-spaces.nvim

return {
    'tenxsoydev/tabs-vs-spaces.nvim',

    -- load this plugin only after using the below keymap
    keys = {
        { '<leader>ct', ':TabsVsSpacesConvert', desc = 'Convert tabs to spaces OR vice versa' }
    },

    config = function()
        local tabsvspace = require("tabs-vs-spaces")

        -- SETUP
        tabsvspace.setup {
            -- Preferred indentation. Possible values: "auto"|"tabs"|"spaces".
            -- "auto" detects the dominant indentation style in a buffer and highlights deviations.
            indentation = "auto",
            -- Use a string like "DiagnosticUnderlineError" to link the `TabsVsSpace` highlight to another highlight.
            -- Or a table valid for `nvim_set_hl` - e.g. { fg = "MediumSlateBlue", undercurl = true }.
            -- NOTE: Disabled because too much visual clutter
            -- highlight = "DiagnosticUnderlineHint",
            highlight = "",
            -- Priority of highight matches.
            priority = 20,
            ignore = {
                filetypes = {},
                -- Works for normal buffers by default.
                buftypes = {
                    "acwrite",
                    "help",
                    "nofile",
                    "nowrite",
                    "quickfix",
                    "terminal",
                    "prompt",
                },
            },
            standartize_on_save = false,
            -- Enable or disable user commands see Readme.md/#Commands for more info.
            user_commands = true,
        }

        -- TEST:
        print("Hello from lazy tabs-vs-spaces")
    end

}
