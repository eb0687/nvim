local M = {}

-- SOURCE: https://jli69.github.io/blog/2025/06/28/neovim-with-godot.html

-- Pipe for godothost
local pipe = "./godothost"

local function server_running()
    local serverlist = vim.fn.serverlist()
    for _, server in ipairs(serverlist) do
        if pipe == server then
            return true
        end
    end
    return false
end

M.start_godot_server = function()
    -- find project root (must contain project.godot)
    local root_dir = vim.fs.dirname(vim.fs.find({ "project.godot" }, { upward = true })[1])
    if root_dir == nil then
        return
    end
    if server_running() then
        return
    end
    vim.fn.serverstart(pipe)
    print("Started godot server: " .. pipe)
end

return M
