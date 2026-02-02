local M = {}

function M.format_filename()
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname == "" then
        if vim.bo.modified then
            return "New File"
        end
        return "Unammed"
    end

    local filename = MiniStatusline.section_filename({})
    local suffix = ""
    if vim.bo.readonly or not vim.bo.modifiable then
        suffix = suffix .. " "
    end
    return filename .. suffix
end

return M
