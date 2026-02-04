local M = {}

function M.set(group, text)
    return "%#" .. group .. "#" .. text
end

return M
