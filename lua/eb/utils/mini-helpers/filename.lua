local M = {}

function M.format_filename()
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname == "" then
        if vim.bo.modified then
            return "New File"
        end
        return "Unammed"
    end

    local statusline = require("mini.statusline")
    local trunc_width = 100
    local filename = statusline.section_filename({ trunc_width = trunc_width })

    if statusline.is_truncated(trunc_width) then
        filename = vim.fn.fnamemodify(bufname, ":t")
    end

    local suffix = ""
    if vim.bo.readonly or not vim.bo.modifiable then
        suffix = suffix .. " "
    end
    return filename .. suffix
end

return M
