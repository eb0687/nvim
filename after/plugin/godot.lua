-- -- Godot.lua

-- -- [[[ SETUP

-- -- local ok, godot = pcall(require, "godot")
-- -- if not ok then
-- --     return
-- -- end
-- local status_ok, godot = pcall(require, "godot")
-- if not status_ok then
--     return
-- end

-- -- default config
-- local config = {
--     bin = "godot",
--     -- gui = {
--     --     console_config = @config for vim.api.nvim_open_win
--     -- },
-- }

-- godot.setup(config)

-- -- ]]]
-- -- [[[ KEYMAPS

-- local keymap = function(keys, func, desc)
--     if desc then
--         desc = 'GODOT: ' .. desc
--     end

--     vim.keymap.set('n', keys, func, { desc = desc })
-- end
-- keymap("<leader>dr", godot.debugger.debug, 'Godot Debug')
-- keymap("<leader>dd", godot.debugger.debug_at_cursor, 'Godot Debug at Cursor')
-- keymap("<leader>dq", godot.debugger.quit, 'Godot Debug Quit')
-- keymap("<leader>dc", godot.debugger.continue, 'Godot Debug Continue')
-- keymap("<leader>ds", godot.debugger.step, 'Godot Debug Step')

-- -- ]]]

-- -- TEST:
-- -- print("Hello from AFTER/GODOT")
