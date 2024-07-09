--   _____.__                               .__
-- _/ ____\  |   ______  _  __    _______  _|__| _____
-- \   __\|  |  /  _ \ \/ \/ /   /    \  \/ /  |/     \
--  |  |  |  |_(  <_> )     /   |   |  \   /|  |  Y Y  \
--  |__|  |____/\____/ \/\_/ /\ |___|  /\_/ |__|__|_|  /
--                           \/      \/              \/
-- https://github.com/arjunmahishi/flow.nvim

return {
    "arjunmahishi/flow.nvim",
    enabled = false,
    config = function()
        local flow = require("flow")
        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_normal = custom_helpers.keymap_normal

        flow.setup({
            output = {
                buffer = true,
                size = "auto",
                focused = true,
                modifiable = true,
            },
            window_override = {
                border = "single",
            },
        })

        local keymap = function(keys, func, desc)
            if desc then
                desc = "FLOW: " .. desc
            end

            vim.keymap.set("n", keys, func, { desc = desc })
        end

        keymap_normal("<leader>rr", ":FlowRunFile<CR>", "FLOW", true, "execute the entire file")
        keymap_normal("<leader>lr", ":FlowRunSelected<CR>", "FLOW", true, "execute the current selection")
    end,
}
