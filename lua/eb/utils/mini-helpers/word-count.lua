local M = {}

local fn = vim.fn

local highlight = require("eb.utils.apply_highlight")

function M.word_count(trunc_width)
    if trunc_width and require("mini.statusline").is_truncated(trunc_width) then
        return ""
    end

    local wc = vim.fn.wordcount()
    local starts = fn.line("v")
    local ends = fn.line(".")
    local lines = starts <= ends and ends - starts + 1 or starts - ends + 1
    -- Visual mode selection word count
    if wc["visual_words"] then
        return highlight.set("MiniStatuslineLineCount", tostring(lines) .. " Lines" .. " / ")
            .. highlight.set("MiniStatuslineWordCount", wc["visual_words"] .. " Words" .. " / ")
            .. highlight.set("MiniStatusLineCharCount", wc["visual_chars"] .. " Chars ")
    else
        return highlight.set("MiniStatuslineWordCount", wc["words"] .. " Words ")
    end
end

function M.filetype()
    local ft = vim.opt_local.filetype:get()
    local count = {
        text = true,
        txt = true,
        markdown = true,
    }
    return count[ft] ~= nil
end

return M
