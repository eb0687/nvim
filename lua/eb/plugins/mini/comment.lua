-- MINI COMMENT
-- SOURCE: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-comment.md

local M = {}

function M.setup()
    local comment = require("mini.comment")
    comment.setup({
        options = {
            custom_commentstring = function()
                return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
            end,
        },
    })
end

return M
