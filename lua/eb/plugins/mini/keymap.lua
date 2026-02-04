-- MINI KEYMAP
-- SOURCE: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-keymap.md

local M = {}

function M.setup()
    local notify_many_keys = function(key)
        local lhs = string.rep(key, 5)
        local action = function()
            vim.notify("Too many " .. key)
        end
        require("mini.keymap").map_combo({ "n", "x" }, lhs, action)
    end
    notify_many_keys("h")
    notify_many_keys("j")
    notify_many_keys("k")
    notify_many_keys("l")

    local map_combo = require("mini.keymap").map_combo
    -- Support most common modes. This can also contain 't', but would
    -- only mean to press `<Esc>` inside terminal.
    local mode = { "i", "c", "x", "s" }
    map_combo(mode, "jk", "<BS><BS><Esc>")
    -- To not have to worry about the order of keys, also map "kj"
    map_combo(mode, "kj", "<BS><BS><Esc>")
    -- Escape into Normal mode from Terminal mode
    map_combo("t", "jk", "<BS><BS><C-\\><C-n>")
    map_combo("t", "kj", "<BS><BS><C-\\><C-n>")
end

return M
