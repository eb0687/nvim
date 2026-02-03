-- https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#using-external-source-for-diff
local M = {}

vim.api.nvim_set_hl(0, "MiniStatuslineDiffAdded", require("eb.utils.mini-helpers.colors").diff.added)
vim.api.nvim_set_hl(0, "MiniStatuslineDiffChanged", require("eb.utils.mini-helpers.colors").diff.changed)
vim.api.nvim_set_hl(0, "MiniStatuslineDiffRemoved", require("eb.utils.mini-helpers.colors").diff.removed)

local function apply_highlight(group, text)
    return "%#" .. group .. "#" .. text
end

function M.diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if not gitsigns then
        return ""
    end
    local parts = {}
    local added = gitsigns.added or 0
    local changed = gitsigns.changed or 0
    local removed = gitsigns.removed or 0
    if added > 0 then
        table.insert(parts, apply_highlight("MiniStatuslineDiffAdded", "+" .. added))
    end
    if changed > 0 then
        table.insert(parts, apply_highlight("MiniStatuslineDiffChanged", "~" .. changed))
    end
    if removed > 0 then
        table.insert(parts, apply_highlight("MiniStatuslineDiffRemoved", "-" .. removed))
    end
    return table.concat(parts, " ")
end
return M
