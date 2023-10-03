--  _           _            _     _     _             _    _ _
-- (_)_ __   __| | ___ _ __ | |_  | |__ | | __ _ _ __ | | _| (_)_ __   ___
-- | | '_ \ / _` |/ _ \ '_ \| __| | '_ \| |/ _` | '_ \| |/ / | | '_ \ / _ \
-- | | | | | (_| |  __/ | | | |_  | |_) | | (_| | | | |   <| | | | | |  __/
-- |_|_| |_|\__,_|\___|_| |_|\__| |_.__/|_|\__,_|_| |_|_|\_\_|_|_| |_|\___|
-- https://github.com/lukas-reineke/indent-blankline.nvim

return {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",

    config = function()
        vim.opt.list = true
        vim.opt.list = true
        -- vim.opt.listchars:append "space:⋅"
        -- vim.opt.listchars:append("eol:↴")

        require("ibl").setup {
            enabled = true,
            indent = {
                char = '│',
                priority = 2,
            },
            scope = {
                enabled = true,
                show_start = true,
                show_end = true,
            }
        }
        -- TEST:
        -- print("Hello from lazy indent-blankline")
    end
}
