local M = {}
--------------------------------------------------------------------------------

local g = vim.g

-- statusline component, showing current and total quickfix item
-- Define highlight groups
vim.api.nvim_set_hl(0, "MyHighlightIcon", { bg = "#1D2021", fg = "#d3869b" })
vim.api.nvim_set_hl(0, "MyHighlightCount", { bg = "#1D2021", fg = "#a9b665" })

-- Helper function to apply highlight
local function apply_highlight(group, text)
    return "%#" .. group .. "#" .. text
end

function M.counter()
    local totalItems = #vim.fn.getqflist()
    if totalItems == 0 then
        return ""
    end
    local out = apply_highlight("MyHighlightIcon", " ")
    if g.qfCount then
        out = out .. apply_highlight("MyHighlightCount", tostring(g.qfCount)) .. "/"
    end
    out = out .. apply_highlight("MyHighlightCount", tostring(totalItems))
    return out
end

return M
