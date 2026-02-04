-- MINI CURSORWORD
-- SOURCE: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-cursorword.md

local M = {}

function M.setup()
    local cursorword = require("mini.cursorword")
    -- cursorword.setup({ delay = 50 })
    cursorword.setup()
end

return M
