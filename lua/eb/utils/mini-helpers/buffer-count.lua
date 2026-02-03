local M = {}

vim.api.nvim_set_hl(0, "BufferHighlightIcon", { bg = "#1D2021", fg = "#8ec07c" })

local function apply_highlight(group, text)
    return "%#" .. group .. "#" .. text
end

-- SOURCE: https://github.com/linkarzu/dotfiles-latest/blob/main/neovim/neobean/lua/config/options.lua#L26
-- https://youtu.be/ldfxEda_mzc?t=385
function M.count_buffers(trunc_width)
    if trunc_width and MiniStatusline.is_truncated(trunc_width) then
        return ""
    end

    local buffers = vim.fn.execute("ls")
    local count = 0
    -- Match only lines that represent buffers, typically starting with a number followed by a space
    for line in string.gmatch(buffers, "[^\r\n]+") do
        if string.match(line, "^%s*%d+") then
            count = count + 1
        end
    end
    local icon = apply_highlight("BufferHighlightIcon", " ") -- Icon with highlight
    local out = icon .. tostring(count)
    return out
end

return M
