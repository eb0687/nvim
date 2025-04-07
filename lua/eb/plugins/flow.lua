--   _____.__                               .__
-- _/ ____\  |   ______  _  __    _______  _|__| _____
-- \   __\|  |  /  _ \ \/ \/ /   /    \  \/ /  |/     \
--  |  |  |  |_(  <_> )     /   |   |  \   /|  |  Y Y  \
--  |__|  |____/\____/ \/\_/ /\ |___|  /\_/ |__|__|_|  /
--                           \/      \/              \/
-- https://github.com/arjunmahishi/flow.nvim

-- NOTE: no longer using this, replaced with code runner and not even using that as much

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

        keymap_normal("<leader>rr", ":FlowRunFile<CR>", "FLOW", true, "execute the entire file")
        keymap_normal("<leader>lr", ":FlowRunSelected<CR>", "FLOW", true, "execute the current selection")
    end,
}
