-- copilot.lua
-- https://github.com/zbirenbaum/copilot.lua

return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        local copilot = require("copilot")
        copilot.setup({
            panel = {
                enabled = false,
            },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                accept = false,
            },
            filetypes = {
                ["*"] = true,
            },
            server_opts_overrides = {
                settings = {
                    telemetry = {
                        telemetryLevel = "off",
                    },
                },
            },
        })

        -- Use Tab to accept copilot suggestion
        vim.keymap.set("i", "<Tab>", function()
            if require("copilot.suggestion").is_visible() then
                return require("copilot.suggestion").accept()
            else
                return "<Tab>"
            end
        end, { silent = true })
    end,
}
