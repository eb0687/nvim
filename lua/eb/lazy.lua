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

-- Install plugins here
local plugins = {

    'nvim-lua/popup.nvim', -- An implementation of the Popup API from vim in Neovim

    -- Utilities
    'farmergreg/vim-lastplace',       -- https://github.com/farmergreg/vim-lastplace
    'Pocco81/true-zen.nvim', -- https://github.com/Pocco81/true-zen.nvim
    'jvirtanen/vim-hcl',
    'mboughaba/i3config.vim',
    'folke/todo-comments.nvim',
    'mbbill/undotree',             -- https://github.com/mbbill/undotree

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = 'nvim-treesitter/nvim-treesitter',
    },
    'HiPhish/rainbow-delimiters.nvim', -- https://gitlab.com/HiPhish/rainbow-delimiters.nvim

    -- Git
    'tpope/vim-fugitive',

    -- FZF
    'ibhagwan/fzf-lua', -- https://github.com/ibhagwan/fzf-lua

    -- HTML & CSS
    {
        'aurum77/live-server.nvim',
        build = function()
            require "live_server.util".install()
        end,
        cmd = {
            'LiveServer',
            'LiveServerStart',
            'LiveServerStop' },
    },
}

-- these options are passed into the lazy setup function below
local opts = {
    install = {
        colorscheme = { "gruvbox-material" }
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false,
    },
}

require("lazy").setup({
    { import = "eb.plugins" },   -- plugins configs managed by lazy
    { import = "eb.plugins.lsp" }, -- lsp configs managed by lazy
    plugins
}, opts)
