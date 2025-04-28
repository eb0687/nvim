-- NOTE: Toggles line numbers
-- source: https://github.com/pwnwriter/pwnvim/blob/main/lua/modules.lua#L3
local cmds = { "nu!", "rnu!", "nonu!" }
local current_index = 1

local function toggle_numbering()
    current_index = current_index % #cmds + 1
    vim.cmd("set " .. cmds[current_index])
    local signcolumn_setting = "auto"
    if cmds[current_index] == "nonu!" then
        signcolumn_setting = "yes:4"
    end
    vim.opt.signcolumn = signcolumn_setting
end

vim.api.nvim_create_user_command("ToggleLineNumbers", function()
    toggle_numbering()
end, {})
