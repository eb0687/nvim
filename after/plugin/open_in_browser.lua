-- NOTE: Open links under cursor in web browser

-- helper function to detech if in WSL
local function is_wsl()
    local handle = io.popen("grep -qi microsoft /proc/version && echo true || echo false")

    if handle == nil then
        return false
    end
    local result = handle:read("*a")
    handle:close()

    return result:match("^%s*(.-)%s*$") == "true"
end

local function open_in_browser()
    local target = vim.fn.expand("<cfile>")
    -- local safe_target = vim.fn.shellescape(target) -- Escape the file for safe use in shell commands
    if is_wsl() then
        vim.ui.open(target, {
            cmd = {
                "wslview",
            },
        })
    else
        vim.ui.open(target, {
            cmd = {
                "xdg-open",
            },
        })
        -- vim.fn.system("xdg-open " .. safe_target)
    end
end

vim.api.nvim_create_user_command("OpenInBrowser", function()
    open_in_browser()
end, { desc = "Conditionally open web browser link based on linux or wsl" })
