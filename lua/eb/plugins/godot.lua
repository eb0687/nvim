--                   _       _
--    __ _  ___   __| | ___ | |_
--   / _` |/ _ \ / _` |/ _ \| __|
--  | (_| | (_) | (_| | (_) | |_
--  \__, |\___/ \__,_|\___/ \__|
--  |___/
-- https://github.com/Lommix/godot.nvim

-- NOTE: this is only used on my windows desktop which has godot setup
-- possible disabling this in the near future as I am currently not doing any
-- game dev.

return {
    'lommix/godot.nvim',
    lazy = true,

    config = function()
        local godot = require('godot')

        -- SETUP
        godot.setup({
            bin = "godot",
            -- gui = {
            --     console_config = @config for vim.api.nvim_open_win
            -- },
        })

        -- KEYMAPS
        local keymap = function(keys, func, desc)
            if desc then
                desc = 'GODOT: ' .. desc
            end

            vim.keymap.set('n', keys, func, { desc = desc })
        end
        keymap("<leader>dr", godot.debugger.debug, 'Godot Debug')
        keymap("<leader>dd", godot.debugger.debug_at_cursor, 'Godot Debug at Cursor')
        keymap("<leader>dq", godot.debugger.quit, 'Godot Debug Quit')
        keymap("<leader>dc", godot.debugger.continue, 'Godot Debug Continue')
        keymap("<leader>ds", godot.debugger.step, 'Godot Debug Step')

        -- TEST:
        print("Hello from lazy godot")
    end
}
