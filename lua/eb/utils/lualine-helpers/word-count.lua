local M = {}

local fn = vim.fn
function M.word_count()
    local wc = vim.fn.wordcount()
    local starts = fn.line("v")
    local ends = fn.line(".")
    local lines = starts <= ends and ends - starts + 1 or starts - ends + 1
    if wc["visual_words"] then -- text is selected in visual mode
        return tostring(lines) .. " Lines / " .. wc["visual_words"] .. " Words / " .. wc["visual_chars"] .. " Chars "
    else -- all of the document
        return wc["words"] .. " Words"
    end
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
