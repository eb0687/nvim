-- local M = require("lualine.components.diff"):extend()

-- function M:init(options)
--     options.symbols = vim.tbl_extend("keep", options.symbols or {}, {
--         added = " ",
--         modified = " ",
--         removed = " "
--     })
--     M.super.init(self, options)
-- end

-- return M

-- https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#using-external-source-for-diff
local M = {}

function M.diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

return M
