-- sniprun (https://github.com/michaelb/sniprun)
-- https://michaelb.github.io/sniprun/sources/README.html#

-- protective call so nothing breaks if nvim-tree is missing
local status_ok, sniprun = pcall(require, "sniprun")
if not status_ok then
    return
end

-- SETUP [[[

sniprun.setup{

    display = {

        -- # NOTE: Select only 1 of the below

        -- Classic
        -- "VirtualText",             --# display results as virtual text
        "TempFloatingWindow",      --# display results in a floating window
        -- "LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText[Ok/Err]
        -- "Terminal",                --# display results in a vertical split
        -- "TerminalWithCode",        --# display results and code history in a vertical split
        -- "NvimNotify",              --# display with the nvim-notify plugin
        -- "Api"                      --# return output to a programming interface
    },
    snipruncolors = {
        SniprunFloatingWinOk = {fg="#A9B665"},
        SniprunFloatingWinErr = {fg="#EA6962"},
    },
    borders = "single"
}

-- ]]]
-- KEYMAP [[[

-- Variables
local keymap_visual = function(keys, func, desc)
    if desc then
        desc = 'Sniprun: ' .. desc
    end

    vim.keymap.set('v', keys, func, { desc = desc })
end

-- Bindings
keymap_visual('<leader>lr', ':SnipRun<CR>', 'Run highlighted command')


-- ]]]

-- TEST:
-- print("Hello from AFTER/SNIPRUN")
