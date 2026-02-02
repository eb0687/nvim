local M = {}

function M.status()
    local recording = vim.fn.reg_recording()
    if recording == "" then
        return ""
    end

    return "󰑊 " .. recording
end

return M
