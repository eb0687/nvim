-- lazy.nvim
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

    'nvim-lua/popup.nvim',    -- An implementation of the Popup API from vim in Neovim

    'romgrk/barbar.nvim',
    'nvim-lualine/lualine.nvim',

    -- Utilities
    'lukas-reineke/indent-blankline.nvim',
    'tenxsoydev/tabs-vs-spaces.nvim', -- https://github.com/tenxsoydev/tabs-vs-spaces.nvim
    'windwp/nvim-autopairs',
    'ThePrimeagen/harpoon',           -- https://github.com/ThePrimeagen/harpoon
    'farmergreg/vim-lastplace',       -- https://github.com/farmergreg/vim-lastplace
    'kylechui/nvim-surround',         -- https://github.com/kylechui/nvim-surround
    {
        'phaazon/hop.nvim',
        branch = 'v2'
    },
    'Pocco81/true-zen.nvim',          -- https://github.com/Pocco81/true-zen.nvim
    'jvirtanen/vim-hcl',
    'mboughaba/i3config.vim',
    'ojroques/nvim-osc52',         -- copy text to the system clipboard using the ANSI OSC52 sequence -- https://github.com/ojroques/nvim-osc52
    'norcalli/nvim-colorizer.lua', -- https://github.com/norcalli/nvim-colorizer.lua
    'folke/todo-comments.nvim',
    'mbbill/undotree',             -- https://github.com/mbbill/undotree
    {
        'CRAG666/code_runner.nvim',
        dependencies = 'nvim-lua/plenary.nvim'
    },
    {
        'michaelb/sniprun',
        build = 'sh ./install.sh'
    },
    'epwalsh/obsidian.nvim',

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

    -- LSP
    'neovim/nvim-lspconfig',             -- plugin to enable LSP - https://github.com/neovim/nvim-lspconfig
    'williamboman/mason.nvim',           -- plugin to auto download language servers - https://github.com/williamboman/mason.nvim
    'williamboman/mason-lspconfig.nvim', -- plugin required for mason - https://github.com/williamboman/mason-lspconfig.nvim

    -- Null-Ls
    'jose-elias-alvarez/null-ls.nvim', -- syntax formatter - https://github.com/jose-elias-alvarez/null-ls.nvim

    -- Git
    'lewis6991/gitsigns.nvim', -- plugin for git integration
    'ThePrimeagen/git-worktree.nvim',
    'tpope/vim-fugitive',

    -- FZF
    'ibhagwan/fzf-lua', -- https://github.com/ibhagwan/fzf-lua

    -- Markdown
    {
        'jakewvincent/mkdnflow.nvim',
        -- rocks = 'luautf8', -- Ensures optional luautf8 dependency is installed
    },

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

    -- Godot
    'lommix/godot.nvim',
}

-- these options are passed into the lazy setup function below
local opts = {
    install = {
        colorscheme = {"gruvbox-material"}
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
    {import = "eb.plugins"}, -- plugins configs managed by lazy
    plugins
},opts)
