local M = {}

function M.toggle_copilot()
    if vim.g.copilot_status == nil then
        vim.g.copilot_status = true
    end
    if vim.g.copilot_status then
        vim.cmd("Copilot disable")
        vim.g.copilot_status = false
        print("Copilot disabled")
    else
        vim.cmd("Copilot enable")
        vim.g.copilot_status = true
        print("Copilot enabled")
    end
end

return M
