--   _   _       _                 _
--  | \ | |_   _(_)_ __ ___       | |_ _ __ ___  ___
--  |  \| \ \ / / | '_ ` _ \ _____| __| '__/ _ \/ _ \
--  | |\  |\ V /| | | | | | |_____| |_| | |  __/  __/
--  |_| \_| \_/ |_|_| |_| |_|      \__|_|  \___|\___|
-- https://github.com/nvim-tree/nvim-tree.lua

-- NOTE: disabling thing for now and replacing with oil.nvim

return {

    "nvim-tree/nvim-tree.lua",
    enabled = false,
    events = "VeryLazy",

    -- keys = {
    --     { "<leader>e", function()
    --         local api = require('nvim-tree.api')
    --         api.tree.toggle()
    --     end,
    --         'NvimTree toggle' }
    -- },

    dependencies = {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },

    config = function()
        local nvimtree = require("nvim-tree")
        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_normal = custom_helpers.keymap_normal

        -- SETUP
        nvimtree.setup({

            disable_netrw = true,
            -- create_in_closed_folder = true,
            update_focused_file = {
                enable = true,
                update_root = true,
            },

            view = {
                adaptive_size = false,
                centralize_selection = true,
                width = 40,
                -- height = 30,
                side = "left",
                preserve_window_proportions = false,
                number = true,
                relativenumber = true,
                signcolumn = "yes",
            },
            renderer = {
                add_trailing = true,
                group_empty = false,
                highlight_git = true,
                full_name = false,
                highlight_opened_files = "name",
                root_folder_modifier = ":~",
                indent_markers = {
                    enable = true,
                    inline_arrows = true,
                    icons = {
                        corner = "└",
                        edge = "│",
                        item = "│",
                        none = " ",
                    },
                },
                icons = {
                    webdev_colors = true,
                    git_placement = "before",
                    padding = " ",
                    symlink_arrow = " ➛ ",
                    show = {
                        git = true,
                    },
                    glyphs = {
                        git = {
                            unstaged = "",
                            staged = "S",
                            unmerged = "",
                            renamed = "➜",
                            untracked = "U",
                            deleted = "",
                            ignored = "◌",
                        },
                    },
                },
                symlink_destination = true,
            },
            diagnostics = {
                enable = true,
                show_on_dirs = true,
                icons = {
                    hint = "",
                    info = "",
                    warning = "",
                    error = "",
                },
            },
            git = {
                enable = true,
                ignore = true,
                show_on_dirs = true,
                timeout = 500,
            },
            filters = {
                dotfiles = true,
            },
            log = {
                enable = false,
                truncate = true,
                types = {
                    all = true,
                    config = false,
                    copy_paste = false,
                    dev = false,
                    diagnostics = false,
                    git = false,
                    profile = false,
                    watcher = false,
                },
            },
        })

        keymap_normal("<leader>e", function()
            local api = require("nvim-tree.api")
            api.tree.toggle()
        end, "NVIMTREE", true, "NvimTree toggle")

        -- TEST:
        -- print("Hello from lazy nvim-tree")
    end,
}
