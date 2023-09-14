-- lazy.nvim
-- https://github.com/folke/lazy.nvim

-- Bootstrap
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
    'nvim-lua/plenary.nvim',  -- Useful lua functions used by lots of plugins

    -- Colorscheme & Aesthetics
    'sainnhe/gruvbox-material', -- gruvbox material colorscheme
    'romgrk/barbar.nvim',
    'kyazdani42/nvim-web-devicons',
    'nvim-lualine/lualine.nvim',

    -- Utilities
    'lukas-reineke/indent-blankline.nvim',
    'tenxsoydev/tabs-vs-spaces.nvim', -- https://github.com/tenxsoydev/tabs-vs-spaces.nvim
    'windwp/nvim-autopairs',
    'ThePrimeagen/harpoon',           -- https://github.com/ThePrimeagen/harpoon
    'kyazdani42/nvim-tree.lua',       -- https://github.com/kyazdani42/nvim-tree.lua
    'farmergreg/vim-lastplace',       -- https://github.com/farmergreg/vim-lastplace
    'tpope/vim-commentary',           -- https://github.com/tpope/vim-commentary
    'kylechui/nvim-surround',         -- https://github.com/kylechui/nvim-surround
    {
        'phaazon/hop.nvim',
        branch = 'v2'
    },
    'Pocco81/true-zen.nvim',          -- https://github.com/Pocco81/true-zen.nvim
    'christoomey/vim-tmux-navigator', -- better navigation between nvim splits and tmux panes -- https://github.com/christoomey/vim-tmux-navigator
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

    -- Telescope
    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-github.nvim',

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

    -- Completions (cmp)
    'hrsh7th/nvim-cmp',                    -- main completion plugin
    'hrsh7th/cmp-buffer',                  -- plugin for buffer completion
    'hrsh7th/cmp-path',                    -- plugin for path completion
    'saadparwaiz1/cmp_luasnip',            -- plugin for snippet completion
    'hrsh7th/cmp-cmdline',                 -- plugin for command line completion
    'hrsh7th/cmp-nvim-lsp',                -- plugin for lsp completion
    'hrsh7th/cmp-nvim-lua',                -- plugin for nvim-lua completion
    'hrsh7th/cmp-nvim-lsp-signature-help', -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help

    -- Snippets
    'L3MON4D3/LuaSnip',             -- https://github.com/L3MON4D3/LuaSnip
    'rafamadriz/friendly-snippets', -- https://github.com/rafamadriz/friendly-snippets

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

local opts = {}

require("lazy").setup(plugins,opts)
