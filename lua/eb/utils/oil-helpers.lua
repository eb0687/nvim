-- helper functions for oil

local M = {}

local oil = require("oil")

-- toggle between detailed and simple columns in the oil buffer
-- taken from :help oil-actions for more details
local state = {
    is_detailed = false,
}

M.toggle_oil_columns = function()
    if state.is_detailed then
        oil.set_columns({ "icon" })
    else
        oil.set_columns({ "icon", "permissions", "size", "mtime" })
    end
    state.is_detailed = not state.is_detailed
end

return M
