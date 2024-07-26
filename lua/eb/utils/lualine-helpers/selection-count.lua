local M = {}

local fn = vim.fn

function M.selection_count()
    local isVisualMode = fn.mode():find("[Vv]")
    if not isVisualMode then
        return ""
    end
    local starts = fn.line("v")
    local ends = fn.line(".")
    local lines = starts <= ends and ends - starts + 1 or starts - ends + 1
    return " " .. tostring(lines) .. "L " .. "/ " .. tostring(fn.wordcount().visual_chars) .. "C"
end

return M
