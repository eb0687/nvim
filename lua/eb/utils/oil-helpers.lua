-- helper functions for oil

local M = {}

local oil = require("oil")
local telescope_builtin = require("telescope.builtin")

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

M.keymap_opts = function(mode, name, desc)
    if desc then
        desc = name .. ": " .. desc
    end
    return {
        mode = mode,
        nowait = true,
        desc = desc,
    }
end

M.telescope_find_cwd = function()
    telescope_builtin.find_files({
        cwd = oil.get_current_dir(),
    })
    return M.keymap_opts("n", "OIL", "Find files in the current directory")
end

return M
