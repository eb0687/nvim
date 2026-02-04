local M = {}

local highlight = require("eb.utils.apply_highlight")

function M.counter()
    local totalItems = #vim.fn.getqflist()

    if totalItems == 0 then
        return ""
    end

    local out = highlight.set("MiniStatusLineQfIcon", " ")

    if vim.g.qfCount then
        out = out .. highlight.set("MiniStatusLineQfCount", tostring(vim.g.qfCount)) .. "/"
    end

    out = out .. highlight.set("MiniStatusLineQfCount", tostring(totalItems))

    return out
end

return M
