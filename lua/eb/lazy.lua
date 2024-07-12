--   _                              _
--  | | __ _ _____   _   _ ____   _(_)_ __ ___
--  | |/ _` |_  / | | | | '_ \ \ / / | '_ ` _ \
--  | | (_| |/ /| |_| |_| | | \ V /| | | | | | |
--  |_|\__,_/___|\__, (_)_| |_|\_/ |_|_| |_| |_|
--               |___/
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

-- these options are passed into the lazy setup function below
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
}

local utils = require("eb.utils.custom_helpers")
local hostname = utils.get_hostname()

if hostname == "JIGA" then
    require("lazy").setup({
        { import = "eb.plugins" }, -- plugins configs managed by lazy
        { import = "eb.plugins.lsp" }, -- lsp configs managed by lazy
        { import = "eb.plugins.jiga" }, -- lsp configs managed by lazy
    }, opts)
elseif hostname == "eb-t490" then
    require("lazy").setup({
        { import = "eb.plugins" }, -- plugins configs managed by lazy
        { import = "eb.plugins.lsp" }, -- lsp configs managed by lazy
        { import = "eb.plugins.jiga" }, -- lsp configs managed by lazy
    }, opts)
else
    require("lazy").setup({
        { import = "eb.plugins" }, -- plugins configs managed by lazy
        { import = "eb.plugins.lsp" }, -- lsp configs managed by lazy
    }, opts)
end
