local M = {}

local fn = vim.fn

-- Define highlight groups
vim.api.nvim_set_hl(0, "MyHighlightLines", { bg = "#32302f", fg = "#8ec07c" })
vim.api.nvim_set_hl(0, "MyHighlightWords", { bg = "#32302f", fg = "#83a598" })
vim.api.nvim_set_hl(0, "MyHighlightChars", { bg = "#32302f", fg = "#d3869b" })

-- Helper function to apply highlight
local function apply_highlight(group, text)
    return "%#" .. group .. "#" .. text .. "%*"
end

function M.word_count()
    local wc = vim.fn.wordcount()
    local starts = fn.line("v")
    local ends = fn.line(".")
    local lines = starts <= ends and ends - starts + 1 or starts - ends + 1
    if wc["visual_words"] then -- text is selected in visual mode
        return apply_highlight("MyHighlightLines", tostring(lines) .. " Lines")
            .. " / "
            .. apply_highlight("MyHighlightWords", wc["visual_words"] .. " Words")
            .. " / "
            .. apply_highlight("MyHighlightChars", wc["visual_chars"] .. " Chars ")
    else -- all of the document
        return apply_highlight("MyHighlightWords", wc["words"] .. " Words")
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
