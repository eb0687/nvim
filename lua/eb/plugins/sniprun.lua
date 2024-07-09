--            _
--  ___ _ __ (_)_ __  _ __ _   _ _ __
-- / __| '_ \| | '_ \| '__| | | | '_ \
-- \__ \ | | | | |_) | |  | |_| | | | |
-- |___/_| |_|_| .__/|_|   \__,_|_| |_|
--             |_|
-- https://github.com/michaelb/sniprun
-- https://michaelb.github.io/sniprun/sources/README.html#

return {

    "michaelb/sniprun",
    event = { "BufReadPost", "BufNewFile" },
    build = "sh ./install.sh",
    enabled = true,

    config = function()
        local sniprun = require("sniprun")
        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_visual = custom_helpers.keymap_visual

        -- SETUP
        sniprun.setup({

            display = {

                -- # NOTE: Select only 1 of the below

                -- Classic
                -- "VirtualText",             --# display results as virtual text
                "TempFloatingWindow", --# display results in a floating window
                -- "LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText[Ok/Err]
                -- "Terminal",                --# display results in a vertical split
                -- "TerminalWithCode",        --# display results and code history in a vertical split
                -- "NvimNotify",              --# display with the nvim-notify plugin
                -- "Api"                      --# return output to a programming interface
            },
            snipruncolors = {
                SniprunFloatingWinOk = { fg = "#A9B665" },
                SniprunFloatingWinErr = { fg = "#EA6962" },
            },
            borders = "single",
        })

        keymap_visual("<leader>lr", ":SnipRun<CR>", "SNIPRUN", true, "Run highlighted command")

        -- TEST:
        -- print("Hello from after sniprun")
    end,
}
