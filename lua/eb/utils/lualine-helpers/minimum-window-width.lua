local M = {}

-- NOTE: show modules based on the width of the window
-- https://www.reddit.com/r/neovim/comments/u2uc4p/comment/i4myaxa/?utm_source=share&utm_medium=web2x&context=3

function M.min_window_width(width)
    return function()
        return vim.fn.winwidth(0) > width
    end
end

return M
