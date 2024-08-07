-- Gopher
-- https://github.com/olexsmir/gopher.nvim
return {
    "olexsmir/gopher.nvim",
    ft = "go",
    build = function()
        vim.cmd([[silent! GoInstallDeps]])
    end,
    config = function()
        local gopher = require("gopher")
        gopher.setup({})
    end,
}
