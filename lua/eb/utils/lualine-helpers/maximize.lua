local M = {}

-- https://github.com/declancm/maximize.nvim?tab=readme-ov-file#-statusline--winbar
function M.maximize_status()
    return vim.t.maximized and "" or ""
end

return M
