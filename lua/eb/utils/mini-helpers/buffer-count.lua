-- SOURCE: https://github.com/linkarzu/dotfiles-latest/blob/main/neovim/neobean/lua/config/options.lua#L26
-- SOURCE: https://youtu.be/ldfxEda_mzc?t=385

local M = {}

local highlight = require("eb.utils.apply_highlight")

function M.count_buffers(trunc_width)
    if trunc_width and require("mini.statusline").is_truncated(trunc_width) then
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
    local icon = highlight.set("MiniStatusLineBufferCount", " ")
    local out = icon .. tostring(count)
    return out
end

return M
