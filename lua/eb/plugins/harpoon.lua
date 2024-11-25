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

        local toggle_opts = {
            border = "solid",
            title_pos = "center",
            ui_width_ratio = 0.40,
            title = " Harpoon ",
        }

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
            harpoon.ui:toggle_quick_menu(harpoon:list(), toggle_opts)
        end, "HARPOON", true, "Toggle quick menu")
        keymap_normal("<leader>hr", function()
            harpoon:list():remove()
        end, "HARPOON", true, "Remove from harpoon list")

        -- Jump to harpoon mark
        for i = 1, 5 do
            keymap_normal("<leader>" .. i, function()
                require("harpoon"):list():select(i)
            end, "HARPOON", true, "Harpoon select " .. i)
        end

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
