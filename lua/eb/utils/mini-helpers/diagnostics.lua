local M = {}

vim.api.nvim_set_hl(0, "MiniStatuslineDiagError", require("eb.utils.mini-helpers.colors").diagnostics.error)
vim.api.nvim_set_hl(0, "MiniStatuslineDiagWarn", require("eb.utils.mini-helpers.colors").diagnostics.warn)

local function apply_highlight(group, text)
    return "%#" .. group .. "#" .. text
end
function M.status()
    local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    if errors == 0 and warnings == 0 then
        return ""
    end
    local parts = {}
    if errors > 0 then
        table.insert(parts, apply_highlight("MiniStatuslineDiagError", "E:" .. errors))
    end
    if warnings > 0 then
        table.insert(parts, apply_highlight("MiniStatuslineDiagWarn", "W:" .. warnings))
    end
    return table.concat(parts, " ")
end

return M
