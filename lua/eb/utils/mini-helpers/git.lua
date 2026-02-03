local M = {}

function M.branch_name()
    local git = require("mini.statusline").section_git({ trunc_width = 50 })
    git = git:gsub("^Git:?%s*", "")
    return vim.trim(git)
end

return M
