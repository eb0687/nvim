-- Plugins that do not have any configuration are placed here

return {

    -- https://github.com/christoomey/vim-tmux-navigator
    "christoomey/vim-tmux-navigator",

    -- https://github.com/mboughaba/i3config.vim
    -- TODO: kinda buggy, need to look for an alternative to this
    {
        "mboughaba/i3config.vim",
        ft = {
            "i3config",
        },
    },

    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = "nvim-treesitter/nvim-treesitter",
    },

    -- https://github.com/tpope/vim-fugitive
    {
        "tpope/vim-fugitive",
        cond = vim.fn.isdirectory(".git") == 1,
    },

    -- https://github.com/olrtg/nvim-emmet
    {
        "olrtg/nvim-emmet",
        ft = {
            "javascript",
            "html",
        },
        config = function()
            vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)
        end,
    },

    {
        "windwp/nvim-ts-autotag",
        ft = {
            "html",
            "javascript",
            "typescript",
            "markdown",
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },

    -- https://github.com/sphamba/smear-cursor.nvim
    {
        "sphamba/smear-cursor.nvim",
        event = "VeryLazy",
        opts = {
            smear_between_buffers = true,
            legacy_computing_symbols_support = false,
            stiffness = 0.8,
            trailing_stiffness = 0.5,
            distance_stop_animating = 0.5,
            hide_target_hack = false,
        },
    },
    {
        "j-hui/fidget.nvim",
        opts = {
            notification = {
                window = {
                    winblend = 0,
                },
            },
        },
    },

    {
        "lambdalisue/vim-suda",
    },
    {
        "benomahony/oil-git.nvim",
        dependencies = { "stevearc/oil.nvim" },
    },
}
