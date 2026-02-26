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
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                auto_integrations = true,
                color_overrides = {
                    macchiato = {
                        mantle = "#181926",
                    },
                },
                integrations = {
                    mini = {
                        enabled = true,
                        indentscope_color = "Overlay1",
                    },
                },
                custom_highlights = function(colors)
                    return {
                        NormalFloat = { bg = "" },
                        FloatTitle = { bg = "", fg = colors.yellow },
                        FloatFooter = { bg = "" },
                        FloatBorder = { bg = "", fg = colors.surface2 },
                        -- Mini Various
                        MiniCursorwordCurrent = { underline = true, fg = "", bg = "" },
                        MiniCursorword = { underline = true, fg = "", bg = "" },
                        -- Mini Pick
                        MiniPickNormal = { bg = "" },
                        MiniPickPrompt = { bg = colors.base, fg = colors.peach },
                        MiniPickPromptPrefix = { bg = colors.base, fg = colors.peach },
                        MiniPickBorderText = { bg = colors.base, fg = colors.peach },
                        -- Mini StatusLine
                        MiniStatuslineModeNormal = { bg = colors.mantle, fg = colors.surface2 },
                        MiniStatuslineFilename = { bg = colors.mantle, fg = colors.surface2 },
                        MiniStatuslineFilenameModified = { bg = colors.mantle, fg = colors.green },
                        MiniStatuslineFilenameReadonly = { bg = colors.mantle, fg = colors.red },
                        MiniStatuslineGit = { bg = colors.mantle, fg = colors.blue },
                        MiniStatuslineMacro = { bg = colors.mantle, fg = colors.red },
                        MiniStatuslineLocation = { bg = colors.mantle, fg = colors.surface2 },
                        MiniStatuslineLsp = { bg = colors.mantle, fg = colors.blue },
                        MiniStatusLineLazy = { bg = colors.mantle, fg = colors.green },
                        MiniStatuslineBufferCount = { bg = colors.mantle, fg = colors.green },
                        MiniStatuslineDiagError = { bg = colors.mantle, fg = colors.red },
                        MiniStatuslineDiagWarn = { bg = colors.mantle, fg = colors.yellow },
                        MiniStatuslineDiffAdded = { bg = colors.mantle, fg = colors.green },
                        MiniStatuslineDiffChanged = { bg = colors.mantle, fg = colors.mauve },
                        MiniStatuslineDiffRemoved = { bg = colors.mantle, fg = colors.red },
                        MiniStatuslineReadonly = { bg = colors.mantle, fg = colors.red },
                        MiniStatuslineExecutable = { bg = colors.mantle, fg = colors.mauve },
                        MiniStatuslineModified = { bg = colors.mantle, fg = colors.yellow },
                        MiniStatuslineQfIcon = { bg = colors.mantle, fg = colors.mauve },
                        MiniStatuslineQfCount = { bg = colors.mantle, fg = colors.green },
                        MiniStatuslineLineCount = { bg = colors.mantle, fg = colors.teal },
                        MiniStatuslineWordCount = { bg = colors.mantle, fg = colors.blue },
                        MiniStatuslineCharCount = { bg = colors.mantle, fg = colors.mauve },
                        -- Blink
                        BlinkCmpMenuBorder = { bg = "", fg = colors.teal, bold = true },
                        BlinkCmpMenu = { bg = "", fg = "", bold = true },
                        BlinkCmpSource = { bg = "", fg = "", bold = true },
                        BlinkCmpMenuSelection = { bg = colors.teal, fg = colors.mantle, bold = true },
                        BlinkCmpDocBorder = { bg = "", fg = colors.teal, bold = true },
                        BlinkCmpSignatureHelpBorder = { bg = "", fg = colors.teal, bold = true },
                        -- Oil-Git
                        OilGitAdded = { bg = "", fg = colors.green, bold = true },
                        OilGitModified = { bg = "", fg = colors.yellow, bold = true },
                        OilGitUntracked = { bg = "", fg = colors.surface1, bold = true },
                        -- Custom
                        Visual = { bg = colors.yellow, fg = colors.mantle, bold = true },
                        YankHi = { bg = colors.yellow, fg = colors.mantle, bold = true },
                        MyCursorLine = { bg = colors.yellow, fg = colors.mantle, bold = true },
                        MyBorder = { bg = "", fg = colors.yellow },
                        MsgArea = { fg = colors.surface2 },
                    }
                end,
            })
        end,
    },
}
