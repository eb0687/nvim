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

-- search in the current directory using telescope
M.telescope_find_cwd = function()
    telescope_builtin.find_files({
        cwd = oil.get_current_dir(),
    })
end

M.open_file = function()
    -- Get the current file path and remove the first 5 characters (index 6 onwards)
    local file_path = vim.fn.expand("%:p"):sub(6)
    vim.cmd("!xdg-open " .. file_path)
end

return M
