local M = {}

local highlight = require("eb.utils.apply_highlight")

function M.status(trunc_width)
    if trunc_width and require("mini.statusline").is_truncated(trunc_width) then
        return ""
    end

    local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    if errors == 0 and warnings == 0 then
        return ""
    end
    local parts = {}
    if errors > 0 then
        table.insert(parts, highlight.set("MiniStatuslineDiagError", "E:" .. errors))
    end
    if warnings > 0 then
        table.insert(parts, highlight.set("MiniStatuslineDiagWarn", "W:" .. warnings))
    end
    return table.concat(parts, " ")
end

return M
