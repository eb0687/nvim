local M = {}
--------------------------------------------------------------------------------

local g = vim.g
local cmd = vim.cmd

---checks whether quickfixlist is empty and notifies if it is
---@nodiscard
---@return boolean
local function quickFixIsEmpty()
    if #vim.fn.getqflist() == 0 then
        -- vim.notify(" Quickfix List empty.", vim.log.levels.WARN)
        return true
    end
    return false
end

--------------------------------------------------------------------------------

-- HELPERS

-- statusline component, showing current and total quickfix item
-- Define highlight groups
vim.api.nvim_set_hl(0, "MyHighlightIcon", { bg = "#32302f", fg = "#d3869b" })
vim.api.nvim_set_hl(0, "MyHighlightCount", { bg = "#32302f", fg = "#a9b665" })

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

--------------------------------------------------------------------------------
-- KEYMAPS

---delete the quickfixlist
function M.deleteList()
    if g.qfCount then
        g.qfCount = nil
    end -- de-initialize
    vim.cmd.cexpr("[]")
end

---goto next quickfix and wrap around
function M.next()
    if quickFixIsEmpty() then
        return
    end
    if not g.qfCount then
        g.qfCount = 0
    end -- initialize counter

    local wentToNext = pcall(function()
        cmd("silent cnext")
    end)
    if wentToNext then
        g.qfCount = g.qfCount + 1
        vim.cmd.normal({ "zv", bang = true }) -- open fold(s) under cursor
    else
        cmd("silent cfirst")
        g.qfCount = 1
        -- vim.notify("Wrapping to the beginning.")
    end
end

---goto previous quickfix and wrap around
function M.previous()
    if quickFixIsEmpty() then
        return
    end
    if not g.qfCount then
        g.qfCount = #(vim.fn.getqflist())
    end -- initialize counter

    local wentToPrevious = pcall(function()
        cmd("silent cprevious")
    end)
    if wentToPrevious then
        g.qfCount = g.qfCount - 1
        vim.cmd.normal({ "zv", bang = true }) -- open fold(s) under cursor
    else
        cmd("silent clast")
        g.qfCount = #(vim.fn.getqflist())
        -- vim.notify("Wrapping to the end.")
    end
end

--------------------------------------------------------------------------------
return M
