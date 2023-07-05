-- INDENT-BLANKLINE

-- TODO: create a pcall for this plugin

-- SETUP [[[

vim.opt.list = true
vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
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

-- ]]]

-- TEST:
-- print("Hello from AFTER/INDENT-BLANKLINE")
