local M = {}

-- source: https://github.com/linkarzu/dotfiles-latest/blob/main/neovim/neobean/lua/config/options.lua#L26
-- https://youtu.be/ldfxEda_mzc?t=385
function M.count_buffers()
    local buffers = vim.fn.execute("ls")
    local count = 0
    -- Match only lines that represent buffers, typically starting with a number followed by a space
    for line in string.gmatch(buffers, "[^\r\n]+") do
        if string.match(line, "^%s*%d+") then
            count = count + 1
        end
    end
    return count
end

return M
