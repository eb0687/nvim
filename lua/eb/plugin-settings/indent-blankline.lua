vim.opt.list = true
vim.opt.list = true
-- vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context_start = true,
    show_end_of_line = true,
    filetype_exclude = {
        "startify",
        "help",
        "lspinfo",
        "checkhealth",
        "man",
    },
}
