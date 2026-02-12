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
end

return M
