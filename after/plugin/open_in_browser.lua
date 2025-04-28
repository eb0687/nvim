-- NOTE: Open links under cursor in web browser

-- helper function to detech if in WSL
local function is_wsl()
    local handle = io.popen("grep -qi microsoft /proc/version && echo true || echo false")
    local result = handle:read("*a")
    handle:close()
    return result:match("^%s*(.-)%s*$") == "true"
end

local function open_in_browser()
    local file = vim.fn.expand("<cfile>")
    local escaped_file = vim.fn.shellescape(file) -- Escape the file for safe use in shell commands
    if is_wsl() then
        vim.fn.system("wslview " .. escaped_file)
    else
        vim.fn.system("xdg-open " .. escaped_file)
    end
end

vim.api.nvim_create_user_command("OpenInBrowser", function()
    open_in_browser()
end, {})
