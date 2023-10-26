--  _
-- | |___ _ __        ___  __ _  __ _  __ _
-- | / __| '_ \ _____/ __|/ _` |/ _` |/ _` |
-- | \__ \ |_) |_____\__ \ (_| | (_| | (_| |
-- |_|___/ .__/      |___/\__,_|\__, |\__,_|
--       |_|                    |___/
-- https://github.com/nvimdev/lspsaga.nvim
return {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        { "nvim-tree/nvim-web-devicons", lazy = true },
    },
    config = function()
        local saga = require("lspsaga")

        -- SETUP
        saga.setup({
            ui = {
                code_action = "󰌶",
                diagnostic = "",
                border = "solid",
            },
            symbol_in_winbar = {
                enable = false,
                show_file = false,
            },
            lightbulb = {
                virtual_text = false,
            },
            code_action = {
                -- NOTE: default keymaps and config explanation
                -- https://nvimdev.github.io/lspsaga/codeaction/
                show_server_name = true,
                extend_gitsigns = true,
                num_shortcut = true,
                keys = {
                    quit = "<esc>",
                },
            },
            definition = {
                -- NOTE: for peek_definition keybinds look at the documentation
                -- https://nvimdev.github.io/lspsaga/definition/
                width = 0.6,
                height = 0.5,
            },
            -- https://nvimdev.github.io/lspsaga/finder/
            finder = {
                keys = {
                    vsplit = "v",
                    split = "h",
                },
            },
            -- https://nvimdev.github.io/lspsaga/rename/
            rename = {
                keys = {
                    quit = "<esc>",
                },
            },
            diagnostic = {
                -- https://nvimdev.github.io/lspsaga/diagnostic/
                show_code_action = false,
                border_follow = false,
                text_hl_follow = false,
                diagnostic_only_current = false,
                extend_relatedInformation = true,
                show_layout = "float",
            },
        })

        -- NOTE: disable nvim native virtual text to avoid clutter when setting
        -- diagnostic_only_current to true
        vim.diagnostic.config({
            virtual_text = false,
        })
        vim.o.updatetime = 250
    end,
}
