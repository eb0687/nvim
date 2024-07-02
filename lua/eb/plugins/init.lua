-- Plugins that do not have any configuration are placed here

return {

    -- https://github.com/christoomey/vim-tmux-navigator
    "christoomey/vim-tmux-navigator",

    -- https://github.com/norcalli/nvim-colorizer.lua
    -- TODO: lookup the lua api in :h colorizer.lua
    -- NOTE: replacing with a fork by NVChad
    -- 'norcalli/nvim-colorizer.lua',

    -- https://github.com/NvChad/nvim-colorizer.lua
    -- Defaults: https://github.com/NvChad/nvim-colorizer.lua#customization
    {
        "NvChad/nvim-colorizer.lua",
        cmd = "ColorizerToggle",
        config = function()
            require("colorizer").setup({
                user_default_options = {
                    tailwind = true,
                },
            })
        end,
    },

    -- https://github.com/nvim-lua/popup.nvim
    "nvim-lua/popup.nvim",

    -- https://github.com/jvirtanen/vim-hcl
    {
        "jvirtanen/vim-hcl",
        ft = {
            "hcl",
            "nomad",
            "tf",
            "tfvars",
        },
    },

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

    -- https://github.com/Bekaboo/deadcolumn.nvim
    {
        "Bekaboo/deadcolumn.nvim",
        event = "VeryLazy",
    },

    -- https://github.com/tpope/vim-obsession
    {
        "tpope/vim-obsession",
        event = { "BufReadPre", "BufNewFile" },
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
    -- https://github.com/2KAbhishek/nerdy.nvim
    {
        "2kabhishek/nerdy.nvim",
        dependencies = {
            "stevearc/dressing.nvim",
            "nvim-telescope/telescope.nvim",
        },
        cmd = "Nerdy",
    },
    -- https://github.com/roobert/tailwindcss-colorizer-cmp.nvim
    {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        ft = {
            "javascript",
            "html",
        },
        -- optionally, override the default options:
        config = function()
            require("tailwindcss-colorizer-cmp").setup({
                color_square_width = 2,
            })
        end,
    },

    -- https://github.com/laytan/tailwind-sorter.nvim
    -- NOTE: could not get the prettier-plugin-tailwindcss to work,
    -- using the below module instead.
    -- BUG: the below plugin is not consistent, need to restart nvim for sorting
    -- to apply
    -- throws an error in when running :Lazy, disabling this plugin for now
    -- {
    --     "laytan/tailwind-sorter.nvim",
    --     ft = {
    --         "javascript",
    --         "html",
    --     },
    --     dependencies = {
    --         "nvim-treesitter/nvim-treesitter",
    --         "nvim-lua/plenary.nvim",
    --     },
    --     build = "cd formatter && npm i && npm run build",
    --     config = function()
    --         require("tailwind-sorter").setup({
    --             -- If `true`, automatically enables on save sorting.
    --             on_save_enabled = true,
    --             -- The file patterns to watch and sort.
    --             on_save_pattern = {
    --                 "*.html",
    --                 "*.js",
    --                 "*.jsx",
    --                 "*.tsx",
    --                 "*.twig",
    --                 "*.hbs",
    --                 "*.php",
    --                 "*.heex",
    --                 "*.astro",
    --             },
    --             node_path = "node",
    --         })
    --     end,
    -- },

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
}
