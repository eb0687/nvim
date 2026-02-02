local M = {}

function M.branch_name()
    local git = MiniStatusline.section_git({})
    git = git:gsub("^Git:?%s*", "")
    return vim.trim(git)
end

return M
