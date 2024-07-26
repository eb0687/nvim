local M = {}

function M.word_count()
    local words = vim.fn.wordcount()["words"]
    return "Words: " .. words
end

function M.filetype()
    local ft = vim.opt_local.filetype:get()
    local count = {
        text = true,
        markdown = true,
    }
    return count[ft] ~= nil
end

return M
