--  _
-- | |___ _ __        ___  __ _  __ _  __ _
-- | / __| '_ \ _____/ __|/ _` |/ _` |/ _` |
-- | \__ \ |_) |_____\__ \ (_| | (_| | (_| |
-- |_|___/ .__/      |___/\__,_|\__, |\__,_|
--       |_|                    |___/
-- https://github.com/nvimdev/lspsaga.nvim
return {
    'nvimdev/lspsaga.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons'
    },
    config = function()
        local saga = require('lspsaga')

        -- SETUP
        saga.setup {
            ui = {
                code_action = "󰌶",
                diagnostic = "",
                border = "solid"
            },
            symbol_in_winbar = {
                enable = false,
                show_file = false
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
                    quit = '<esc>'
                }
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
                    vsplit = 'v',
                    split = 'h',
                }
            },
            -- https://nvimdev.github.io/lspsaga/rename/
            rename = {
                keys = {
                    quit = '<esc>',
                }
            },
            diagnostic = {
                -- https://nvimdev.github.io/lspsaga/diagnostic/
                show_code_action = true,
                border_follow = false,
                diagnostic_only_current = true,
                show_layout = 'float'
            }
        }

        -- KEYMAPS
        local keymap = function(keys, func, desc)
            if desc then
                desc = 'LSPSAGA: ' .. desc
            end

            vim.keymap.set('n', keys, func, { desc = desc })
        end

        keymap("[d", ":Lspsaga diagnostic_jump_prev<CR>", "Go to previous diagnostic message")
        keymap("]d", ":Lspsaga diagnostic_jump_next<CR>", "Go to next diagnostic message")
        keymap("gp", ":Lspsaga peek_definition<CR>", "Go to next diagnostic message")
        keymap("rn", ":Lspsaga rename<CR>", "Rename")
        keymap("K", ":Lspsaga hover_doc<CR>", "Hover documentation")
        keymap("<leader>ca", ":Lspsaga code_action<CR>", "Code action")
        keymap("fi", ":Lspsaga finder<CR>", "Finder saga window")
    end,
}
