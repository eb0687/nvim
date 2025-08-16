-- helper functions for oil

local M = {}

local oil = require("oil")
-- local telescope_builtin = require("telescope.builtin")

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
-- M.telescope_find_cwd = function()
--     telescope_builtin.find_files({
--         cwd = oil.get_current_dir(),
--     })
-- end

M.open_file = function()
    -- Get the current file path and remove the first 5 characters (index 6 onwards)
    local file_path = vim.fn.expand("%:p"):sub(6)
    vim.cmd("!xdg-open " .. file_path)
end

M.copy_absolute_path = function()
    require("oil.actions").copy_entry_path.callback()
    local yanked_path = vim.fn.getreg(vim.v.register)
    vim.fn.setreg("+", yanked_path)
    vim.notify("Yanked absolute path: " .. yanked_path, vim.log.levels.INFO)
end

M.copy_relative_path = function()
    local entry = require("oil").get_cursor_entry()
    local dir = require("oil").get_current_dir()

    if not entry or not dir then
        vim.notify("Failed to yank path, no entry or directory found.", vim.log.levels.WARN)
        return
    end

    local relpath = vim.fn.fnamemodify(dir, ":.")
    local yanked_path = relpath .. entry.name
    vim.fn.setreg("+", yanked_path)
    vim.notify("Yanked relative path: " .. yanked_path, vim.log.levels.INFO)
end

-- M.copy_relative_path = function()
--     local entry = oil.get_cursor_entry()
--     local dir = oil.get_current_dir()
--
--     if not entry or not dir then
--         return
--     end
--
--     local relpath = vim.fn.fnamemodify(dir, ":.")
--     vim.fn.setreg("+", relpath .. entry.name)
-- end

local function in_godot_project()
    local cwd = vim.fn.getcwd()
    local project_file = vim.fn.findfile("project.godot", cwd .. ";")
    return project_file ~= ""
end

M.always_hidden = function(name, _)
    if not in_godot_project() then
        return false
    end

    if vim.endswith(name, ".uid") then
        return true
    end

    if name == "godothost" then
        return true
    end

    return false
end

return M
