-- Plugins that do not have any configuration are placed here

return {

    -- https://github.com/christoomey/vim-tmux-navigator
    'christoomey/vim-tmux-navigator',

    -- https://github.com/norcalli/nvim-colorizer.lua
    -- TODO: lookup the lua api in :h colorizer.lua
    -- NOTE: replacing with a fork by NVChad
    -- 'norcalli/nvim-colorizer.lua',

    -- https://github.com/NvChad/nvim-colorizer.lua
    -- Defaults: https://github.com/NvChad/nvim-colorizer.lua#customization
    {
        'NvChad/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup {
                user_default_options = {
                    tailwind = true,
                }
            }
        end
    },

    -- https://github.com/nvim-lua/popup.nvim
    'nvim-lua/popup.nvim',

    -- https://github.com/jvirtanen/vim-hcl
    'jvirtanen/vim-hcl',

    -- https://github.com/mboughaba/i3config.vim
    -- TODO: kinda buggy, need to look for an alternative to this
    'mboughaba/i3config.vim',


    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = 'nvim-treesitter/nvim-treesitter',
    },

    -- https://github.com/tpope/vim-fugitive
    {
        'tpope/vim-fugitive',
        cond = vim.fn.isdirectory('.git') == 1,

    },

    -- https://github.com/ibhagwan/fzf-lua
    -- NOTE: this is a wip, have not really implemented the features in my config
    'ibhagwan/fzf-lua',

    -- https://github.com/aurum77/live-server.nvim
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

    -- https://github.com/Bekaboo/deadcolumn.nvim
    { 'Bekaboo/deadcolumn.nvim' },

    -- https://github.com/tpope/vim-obsession
    { 'tpope/vim-obsession' },

    -- https://github.com/olrtg/nvim-emmet
    {
        "olrtg/nvim-emmet",
        config = function()
            vim.keymap.set({ "n", "v" }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
        end,
    },
    -- https://github.com/2KAbhishek/nerdy.nvim
    {
        '2kabhishek/nerdy.nvim',
        dependencies = {
            'stevearc/dressing.nvim',
            'nvim-telescope/telescope.nvim',
        },
        cmd = 'Nerdy',
    },
    -- https://github.com/roobert/tailwindcss-colorizer-cmp.nvim
    {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        -- optionally, override the default options:
        config = function()
            require("tailwindcss-colorizer-cmp").setup({
                color_square_width = 2,
            })
        end
    }
}
