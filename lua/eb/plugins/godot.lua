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
    "lommix/godot.nvim",
    lazy = true,
    enabled = false,

    config = function()
        local godot = require("godot")
        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_normal = custom_helpers.keymap_normal

        -- SETUP
        godot.setup({
            bin = "godot",
            -- gui = {
            --     console_config = @config for vim.api.nvim_open_win
            -- },
        })

        -- KEYMAPS
        keymap_normal("<leader>dr", godot.debugger.debug, "GODOT", true, "Godot Debug")
        keymap_normal("<leader>dd", godot.debugger.debug_at_cursor, "GODOT", true, "Godot Debug at Cursor")
        keymap_normal("<leader>dq", godot.debugger.quit, "GODOT", true, "Godot Debug Quit")
        keymap_normal("<leader>dc", godot.debugger.continue, "GODOT", true, "Godot Debug Continue")
        keymap_normal("<leader>ds", godot.debugger.step, "GODOT", true, "Godot Debug Step")

        -- TEST:
        -- print("Hello from lazy godot")
    end,
}
