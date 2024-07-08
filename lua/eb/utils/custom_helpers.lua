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

return M
