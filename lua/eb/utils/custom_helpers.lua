local M = {}

-- return hostname of the machine
function M.get_hostname()
    local handle = io.popen("hostname")
    if not handle then
        return nil
    end
    local hostname = handle:read("*a")
    handle:close()
    if not hostname then
        return nil
    end
    return hostname
end

-- function for normal mode keymaps
function M.keymap_normal(lhs, rhs, name, silent, desc)
    if desc then
        desc = name .. ": " .. desc
    end

    vim.keymap.set("n", lhs, rhs, {
        silent = silent,
        desc = desc,
    })
end

return M
