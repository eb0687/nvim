-- SOURCE: https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#using-external-source-for-diff

local M = {}

local highlight = require("eb.utils.apply_highlight")

function M.diff_source(trunc_width)
    if trunc_width and require("mini.statusline").is_truncated(trunc_width) then
        return ""
    end

    local gitsigns = vim.b.gitsigns_status_dict

    if not gitsigns then
        return ""
    end

    local parts = {}
    local added = gitsigns.added or 0
    local changed = gitsigns.changed or 0
    local removed = gitsigns.removed or 0

    if added > 0 then
        table.insert(parts, highlight.set("MiniStatuslineDiffAdded", "+" .. added))
    end
    if changed > 0 then
        table.insert(parts, highlight.set("MiniStatuslineDiffChanged", "~" .. changed))
    end
    if removed > 0 then
        table.insert(parts, highlight.set("MiniStatuslineDiffRemoved", "-" .. removed))
    end
    return table.concat(parts, " ")
end

return M
