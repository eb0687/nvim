--  _           _            _     _     _             _    _ _
-- (_)_ __   __| | ___ _ __ | |_  | |__ | | __ _ _ __ | | _| (_)_ __   ___
-- | | '_ \ / _` |/ _ \ '_ \| __| | '_ \| |/ _` | '_ \| |/ / | | '_ \ / _ \
-- | | | | | (_| |  __/ | | | |_  | |_) | | (_| | | | |   <| | | | | |  __/
-- |_|_| |_|\__,_|\___|_| |_|\__| |_.__/|_|\__,_|_| |_|_|\_\_|_|_| |_|\___|
-- https://github.com/lukas-reineke/indent-blankline.nvim

return {
    'lukas-reineke/indent-blankline.nvim',

    config = function()
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
        -- TEST:
        -- print("Hello from lazy indent-blankline")
    end
}
