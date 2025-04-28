local M = {}

-- NOTE: return hostname of the machine
function M.get_hostname()
    local handle = io.popen("hostname")
    if not handle then
        return nil
    end
    local hostname = handle:read("*a")
    handle:close()
    return hostname and hostname:match("^%s*(.-)%s*$") or nil
end

-------------------------------------------------------------------------------
-- NOTE: Normal mode keymaps
function M.keymap_normal(lhs, rhs, name, silent, desc)
    if desc then
        desc = name .. ": " .. desc
    end

    vim.keymap.set("n", lhs, rhs, {
        silent = silent,
        desc = desc,
    })
end

-------------------------------------------------------------------------------
-- NOTE: Visual mode keymaps
function M.keymap_visual(lhs, rhs, name, silent, desc)
    if desc then
        desc = name .. ": " .. desc
    end

    vim.keymap.set("v", lhs, rhs, {
        silent = silent,
        desc = desc,
    })
end

-------------------------------------------------------------------------------
-- NOTE: Generic keymap
function M.keymap(lhs, rhs, name, silent, desc)
    if desc then
        desc = name .. ": " .. desc
    end

    vim.keymap.set("", lhs, rhs, {
        silent = silent,
        desc = desc,
    })
end

-------------------------------------------------------------------------------
-- NOTE: Silent keymap
function M.keymap_silent(mode, keys, func, desc)
    if desc then
        desc = "CUSTOM: " .. desc
    end
    vim.keymap.set(mode, keys, func, {
        noremap = true,
        silent = true,
        desc = desc,
    })
end

-- NOTE: Loud keymap
function M.keymap_loud(mode, keys, func, desc)
    if desc then
        desc = "CUSTOM: " .. desc
    end
    vim.keymap.set(mode, keys, func, {
        noremap = true,
        silent = false,
        desc = desc,
    })
end

-------------------------------------------------------------------------------
-- NOTE: fix path helper function
function M.expand_path(path)
    if path:sub(1, 1) == "~" then
        return os.getenv("HOME") .. path:sub(2)
    end
    return path
end

-------------------------------------------------------------------------------
-- NOTE: Validate arguments before executing a function or callback, useful for
-- user created commands
function M.validate_args(fargs, min_args, usage_message)
    if #fargs < min_args then
        vim.notify(usage_message, vim.log.levels.WARN)
        return false
    end
    return true
end

-------------------------------------------------------------------------------
-- NOTE: Clear quickfix list
function M.clear_quickfix()
    vim.fn.setqflist({})

    -- Close the quickfix window if it's open
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].buftype == "quickfix" then
            vim.api.nvim_win_close(win, true)
        end
    end

    vim.notify("Quickfix list cleared", vim.log.levels.INFO)
end

-------------------------------------------------------------------------------
-- NOTE: Utility function for keymaps yank to registers
function M.yank_to_register(register)
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    local num_lines = end_line - start_line + 1

    vim.cmd('normal! "' .. register .. "y")

    vim.notify(
        string.format("Yanked %d line(s) to register '%s'", num_lines, register),
        vim.log.levels.INFO,
        { title = "Yank" }
    )
end

return M
