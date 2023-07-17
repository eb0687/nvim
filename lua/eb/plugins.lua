--    ___           _
--   / _ \__ _  ___| | _____ _ __
--  / /_)/ _` |/ __| |/ / _ \ '__|
-- / ___/ (_| | (__|   <  __/ |
-- \/    \__,_|\___|_|\_\___|_|

-- [[[ Automatically install packer
local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end
-- ]]]

-- [[[ Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]
-- ]]]

-- [[[ Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end
--]]]

-- [[[ Have packer use a popup window
-- packer.init {
--   display = {
--     open_fn = function()
--       return require("packer.util").float { border = "rounded" }
--     end,
--   },
-- }
-- ]]]

-- [[[ Install plugins here
return packer.startup(function(use)
    -- Required plugins
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins

    -- Colorscheme & Aesthetics
    use "sainnhe/gruvbox-material" -- gruvbox material colorscheme
    use "romgrk/barbar.nvim"
    use 'kyazdani42/nvim-web-devicons'
    use 'nvim-lualine/lualine.nvim'

    -- Utilities
    use 'lukas-reineke/indent-blankline.nvim'
    use "tenxsoydev/tabs-vs-spaces.nvim" -- https://github.com/tenxsoydev/tabs-vs-spaces.nvim
    use 'windwp/nvim-autopairs'
    use 'ThePrimeagen/harpoon' -- https://github.com/ThePrimeagen/harpoon
    use 'kyazdani42/nvim-tree.lua' -- https://github.com/kyazdani42/nvim-tree.lua
    use 'farmergreg/vim-lastplace' -- https://github.com/farmergreg/vim-lastplace
    use 'tpope/vim-commentary' -- https://github.com/tpope/vim-commentary
    use 'kylechui/nvim-surround' -- https://github.com/kylechui/nvim-surround
    use { 'phaazon/hop.nvim', branch = 'v2' } -- https://github.com/phaazon/hop.nvim
    use 'Pocco81/true-zen.nvim' -- https://github.com/Pocco81/true-zen.nvim
    use 'christoomey/vim-tmux-navigator' -- better navigation between nvim splits and tmux panes -- https://github.com/christoomey/vim-tmux-navigator
    use 'jvirtanen/vim-hcl'
    use 'mboughaba/i3config.vim'
    use { 'ojroques/nvim-osc52' } -- copy text to the system clipboard using the ANSI OSC52 sequence -- https://github.com/ojroques/nvim-osc52
    use { 'norcalli/nvim-colorizer.lua' } -- https://github.com/norcalli/nvim-colorizer.lua
    use { 'folke/todo-comments.nvim' }
    use { 'mbbill/undotree' } -- https://github.com/mbbill/undotree
    -- use {
    --     'klesh/nvim-runscript',
    --     config = function() require("nvim-runscript").setup{} end
    -- } -- https://github.com/klesh/nvim-runscript
    use { 'CRAG666/code_runner.nvim', requires = 'nvim-lua/plenary.nvim' }
    use { 'michaelb/sniprun', run = 'sh ./install.sh'} -- NOTE: testing https://github.com/michaelb/sniprun
    use { 'epwalsh/obsidian.nvim' }

    -- Telescope
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-github.nvim'

    -- Treesitter
    -- Note: :TSUpdate will cause Packer to fail upon the first installation. It will run correctly when updating. To avoid this, call nvim-treesitter.install.update()
    -- Source: https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }

    -- Completions (cmp)
    use 'hrsh7th/nvim-cmp' -- main completion plugin
    use 'hrsh7th/cmp-buffer' -- plugin for buffer completion
    use 'hrsh7th/cmp-path' -- plugin for path completion
    use 'saadparwaiz1/cmp_luasnip' -- plugin for snippet completion
    use 'hrsh7th/cmp-cmdline' -- plugin for command line completion
    use 'hrsh7th/cmp-nvim-lsp' -- plugin for lsp completion
    use 'hrsh7th/cmp-nvim-lua' -- plugin for nvim-lua completion
    use 'hrsh7th/cmp-nvim-lsp-signature-help' -- https://github.com/hrsh7th/cmp-nvim-lsp-signature-help

    -- Snippets
    use 'L3MON4D3/LuaSnip' -- https://github.com/L3MON4D3/LuaSnip
    use 'rafamadriz/friendly-snippets' -- https://github.com/rafamadriz/friendly-snippets

    -- LSP
    use 'neovim/nvim-lspconfig' -- plugin to enable LSP - https://github.com/neovim/nvim-lspconfig
    use 'williamboman/mason.nvim' -- plugin to auto download language servers - https://github.com/williamboman/mason.nvim
    use 'williamboman/mason-lspconfig.nvim' -- plugin required for mason - https://github.com/williamboman/mason-lspconfig.nvim

    -- Null-Ls
    use 'jose-elias-alvarez/null-ls.nvim' -- syntax formatter - https://github.com/jose-elias-alvarez/null-ls.nvim

    -- Git
    use 'lewis6991/gitsigns.nvim' -- plugin for git integration
    use 'ThePrimeagen/git-worktree.nvim'
    use 'tpope/vim-fugitive'

    -- FZF
    use 'ibhagwan/fzf-lua' -- https://github.com/ibhagwan/fzf-lua

    -- Markdown
    use({
        'jakewvincent/mkdnflow.nvim',
        rocks = 'luautf8', -- Ensures optional luautf8 dependency is installed
    }) -- https://github.com/jakewvincent/mkdnflow.nvim

    -- NOTE:: throws an error, disabling for now
    -- use 'ekickx/clipboard-image.nvim' -- https://github.com/ekickx/clipboard-image.nvim 

    -- HTML & CSS
    use({
        "aurum77/live-server.nvim",
        run = function()
            require "live_server.util".install()
        end,
        cmd = { "LiveServer", "LiveServerStart", "LiveServerStop" },
    })

    -- Godot
    use "lommix/godot.nvim"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
-- ]]]
