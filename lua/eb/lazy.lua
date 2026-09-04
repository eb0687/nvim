-- https://github.com/folke/lazy.nvim

-- Bootstrap. This will install lazy.nvim if not available
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
    install = {
        colorscheme = { "gruvbox-material" },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false,
    },
    ui = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
}

require("lazy").setup({
    { import = "eb.plugins" },
    { import = "eb.plugins.lsp" },
}, opts)
require("eb.theme").apply()
