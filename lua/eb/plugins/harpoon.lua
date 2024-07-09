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
    event = "VeryLazy",
    keys = {
        { "<leader>hm", '<cmd>lua require("harpoon.ui").toggle_quick_menu()', "toggle harpoon menu" },
        { "<leader>ha", '<cmd>lua require("harpoon.mark").add_file()', "add files to harpoon" },
        { "<leader>hr", '<cmd>lua require("harpoon.mark").rm_file()', "remove file from harpoon" },
        { "<leader>hc", '<cmd>lua require("harpoon.mark").clear_all()', "clear all files from harpoon" },
        { "<leader>1", '<cmd>lua require("harpoon.ui").nav_file(1)', "Add to harpoon key [1]" },
        { "<leader>2", '<cmd>lua require("harpoon.ui").nav_file(2)', "Add to harpoon key [2]" },
        { "<leader>3", '<cmd>lua require("harpoon.ui").nav_file(3)', "Add to harpoon key [3]" },
        { "<leader>4", '<cmd>lua require("harpoon.ui").nav_file(4)', "Add to harpoon key [4]" },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")
        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_normal = custom_helpers.keymap_normal

        -- local keymap = function(keys, func, desc)
        --     if desc then
        --         desc = "Harpoon: " .. desc
        --     end

        --     vim.keymap.set("n", keys, func, { desc = desc })
        -- end

        keymap_normal("<leader>hm", ui.toggle_quick_menu, "HARPOON", true, "toggle harpoon menu")
        keymap_normal("<leader>ha", mark.add_file, "HARPOON", true, "add file to harpoon")
        keymap_normal("<leader>hr", mark.rm_file, "HARPOON", true, "remove file from harpoon")
        keymap_normal("<leader>hc", mark.clear_all, "HARPOON", true, "clear all files from harpoon")
        keymap_normal("<leader>1", function()
            ui.nav_file(1)
        end, "HARPOON", true, "Add to harpoon key [1]")
        keymap_normal("<leader>2", function()
            ui.nav_file(2)
        end, "HARPOON", true, "Add to harpoon key [2]")
        keymap_normal("<leader>3", function()
            ui.nav_file(3)
        end, "HARPOON", true, "Add to harpoon key [3]")
        keymap_normal("<leader>4", function()
            ui.nav_file(4)
        end, "HARPOON", true, "Add to harpoon key [4]")

        -- TEST:
        -- print("Hello from lazy harpoon")
    end,
}
