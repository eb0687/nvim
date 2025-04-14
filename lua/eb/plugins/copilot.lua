-- copilot.lua
-- https://github.com/zbirenbaum/copilot.lua

return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        local copilot = require("copilot")
        copilot.setup({
            panel = { enabled = false },
            suggestion = { enabled = false },
        })
    end,
}
