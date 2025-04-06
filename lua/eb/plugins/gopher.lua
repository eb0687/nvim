-- Gopher
-- https://github.com/olexsmir/gopher.nvim

-- NOTE: disabling this, not sure if I even need this anymore

return {
    "olexsmir/gopher.nvim",
    enabled = false,
    ft = "go",
    build = function()
        vim.cmd([[silent! GoInstallDeps]])
    end,
    config = function()
        local gopher = require("gopher")
        gopher.setup({})
    end,
}
