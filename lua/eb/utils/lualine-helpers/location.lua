local M = require("lualine.component"):extend()

function M:init(options)
    if options.icon == nil then
        options.icon = {
            "󰍒",
            color = { fg = "#EA6962" },
            align = "left",
        }
    elseif options.icon == false then
        options.icon = nil
    end
    M.super.init(self, options)
end

-- function M:init(options)
--     options.icon = options.icon or {
--         "󰍒",
--         color = { fg = "#EA6962" },
--         align = "left",
--     }
--     M.super.init(self, options)
-- end

function M:update_status()
    local line = vim.fn.line(".")
    local col = vim.fn.virtcol(".")
    return string.format("%d:%d", line, col)
end

return M
