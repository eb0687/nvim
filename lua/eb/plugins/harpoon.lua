--   _
--  | |__   __ _ _ __ _ __   ___   ___  _ __
--  | '_ \ / _` | '__| '_ \ / _ \ / _ \| '_ \
--  | | | | (_| | |  | |_) | (_) | (_) | | | |
--  |_| |_|\__,_|_|  | .__/ \___/ \___/|_| |_|
--                   |_|
-- https://github.com/ThePrimeagen/harpoon

-- TODO:
-- refer to the github page for other integrations and usecases

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_normal = custom_helpers.keymap_normal

        local harpoon = require("harpoon")
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = false,
                save_on_change = true,
                excluded_filetypes = { "harpoon", "alpha", "dashboard", "gitcommit" },
                key = function()
                    return vim.loop.cwd()
                end,
            },
        })

        -- https://github.com/ThePrimeagen/harpoon/tree/harpoon2?tab=readme-ov-file#extend
        harpoon:extend({
            UI_CREATE = function(cx)
                vim.keymap.set("n", "<C-v>", function()
                    harpoon.ui:select_menu_item({ vsplit = true })
                end, { buffer = cx.bufnr })

                vim.keymap.set("n", "<C-h>", function()
                    harpoon.ui:select_menu_item({ split = true })
                end, { buffer = cx.bufnr })
            end,
        })

        keymap_normal("<leader>ha", function()
            harpoon:list():add()
        end, "HARPOON", true, "Add to harpoon list")
        keymap_normal("<leader>hm", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, "HARPOON", true, "Toggle quick menu")
        keymap_normal("<leader>hr", function()
            harpoon:list():remove()
        end, "HARPOON", true, "Remove from harpoon list")

        -- Jump to harpoon mark
        keymap_normal("<leader>1", function()
            harpoon:list():select(1)
        end, "HARPOON", true, "Jump to mark 1")
        keymap_normal("<leader>2", function()
            harpoon:list():select(2)
        end, "HARPOON", true, "Jump to mark 2")
        keymap_normal("<leader>3", function()
            harpoon:list():select(3)
        end, "HARPOON", true, "Jump to mark 3")
        keymap_normal("<leader>4", function()
            harpoon:list():select(4)
        end, "HARPOON", true, "Jump to mark 4")
        keymap_normal("<leader>5", function()
            harpoon:list():select(5)
        end, "HARPOON", true, "Jump to mark 5")

        -- Toggle previous & next buffers stored within Harpoon list
        keymap_normal("<C-n>", function()
            harpoon:list():next()
        end, "HARPOON", true, "Next buffer in harpoon list")
        keymap_normal("<C-p>", function()
            harpoon:list():prev()
        end, "HARPOON", true, "Previous buffer in harpoon list")

        -- TEST:
        -- print("Hello from lazy harpoon")
    end,
}
