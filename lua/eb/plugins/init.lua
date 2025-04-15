-- Plugins that do not have any configuration are placed here

return {

    -- https://github.com/christoomey/vim-tmux-navigator
    "christoomey/vim-tmux-navigator",

    -- https://github.com/NvChad/nvim-colorizer.lua
    -- Defaults: https://github.com/NvChad/nvim-colorizer.lua#customization
    -- NOTE: replaced with mini
    {
        "NvChad/nvim-colorizer.lua",
        cmd = "ColorizerToggle",
        enabled = false,
        config = function()
            require("colorizer").setup({
                user_default_options = {
                    tailwind = true,
                },
            })
        end,
    },

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

    -- NOTE: replaced with tailwind-tools
    -- https://github.com/roobert/tailwindcss-colorizer-cmp.nvim
    -- {
    --     "roobert/tailwindcss-colorizer-cmp.nvim",
    --     ft = {
    --         "javascript",
    --         "html",
    --     },
    --     -- optionally, override the default options:
    --     config = function()
    --         require("tailwindcss-colorizer-cmp").setup({
    --             color_square_width = 2,
    --         })
    --     end,
    -- },

    -- https://github.com/laytan/tailwind-sorter.nvim
    -- NOTE: replaced with tailwind-tools
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

    -- https://github.com/AckslD/nvim-FeMaco.lua
    {
        "AckslD/nvim-FeMaco.lua",
        enabled = false,
        config = function()
            require("femaco").setup()
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

    -- NOTE: replaced with blink
    {
        "zbirenbaum/copilot-cmp",
        enabled = false,
        event = "VeryLazy",
        config = function()
            require("copilot_cmp").setup()
        end,
    },

    {
        "letieu/harpoon-lualine",
        event = "VeryLazy",
        dependencies = {
            {
                "ThePrimeagen/harpoon",
                branch = "harpoon2",
            },
        },
    },

    -- NOTE: have not been using this at all
    -- https://github.com/piersolenski/wtf.nvim
    -- {
    --     "piersolenski/wtf.nvim",
    --     event = "LspAttach",
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --     },
    --     opts = {
    --         search_engine = "google",
    --     },
    --     keys = {
    --         {
    --             "gW",
    --             mode = { "n", "x" },
    --             function()
    --                 require("wtf").ai()
    --             end,
    --             desc = "Debug diagnostic with AI",
    --         },
    --         {
    --             mode = { "n" },
    --             "gw",
    --             function()
    --                 require("wtf").search()
    --             end,
    --             desc = "Search diagnostic with Google",
    --         },
    --     },
    -- },

    {
        -- https://github.com/NStefan002/screenkey.nvim
        "NStefan002/screenkey.nvim",
        enabled = false,
        lazy = true,
        version = "*", -- or branch = "dev", to use the latest commit
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

    -- https://github.com/jmbuhr/otter.nvim
    {
        "jmbuhr/otter.nvim",
        enabled = false,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {},
    },

    -- NOTE: not using this as of now, will play around with custom injections
    -- https://github.com/DariusCorvus/tree-sitter-language-injection.nvim
    -- {
    --     "DariusCorvus/tree-sitter-language-injection.nvim",
    --     enabled = false,
    --     opts = {},
    -- },

    {
        "mg979/vim-visual-multi",
        config = function() end,
    },
}
