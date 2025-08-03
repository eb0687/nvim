-- oil.nvim
-- https://github.com/stevearc/oil.nvim

return {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local oil = require("oil")
        local custom_helpers = require("eb.utils.custom_helpers")
        local oil_helpers = require("eb.utils.oil-helpers")
        local keymap_normal = custom_helpers.keymap_normal
        local toggle_oil_columns = oil_helpers.toggle_oil_columns
        local telescope_find_cwd = oil_helpers.telescope_find_cwd
        local open_file = oil_helpers.open_file
        local copy_abs_path = oil_helpers.copy_absolute_path
        local copy_rel_path = oil_helpers.copy_relative_path

        oil.setup({
            keymaps = {
                -- must be false to unmap the defaults
                ["<C-s>"] = false,
                ["<C-h>"] = false,
                ["<C-l>"] = false,
                ["gx"] = false,
                -- krymaps below
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-v>"] = {
                    "actions.select",
                    opts = { vertical = true },
                    desc = "Open the entry in a vertical split",
                },
                ["<M-h>"] = {
                    "actions.select",
                    opts = { horizontal = true },
                    desc = "Open the entry in a horizontal split",
                },
                ["<C-t>"] = {
                    "actions.select",
                    opts = { tab = true },
                    desc = "Open the entry in new tab",
                },
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["q"] = "actions.close",
                ["<leader>r"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = {
                    "actions.cd",
                    opts = { scope = "tab" },
                    desc = ":tcd to the current oil directory",
                },
                ["gs"] = "actions.change_sort",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
                ["gc"] = {
                    toggle_oil_columns,
                    mode = "n",
                    desc = "Toggle detailed columns in oil",
                },
                ["<leader>ff"] = {
                    telescope_find_cwd,
                    mode = "n",
                    desc = "Find files in the current directory",
                },
                ["<leader>o"] = {
                    open_file,
                    mode = "n",
                    desc = "Open file in default app",
                },
                ["ypa"] = {
                    copy_abs_path,
                    mode = "n",
                    desc = "Copy absolute filepath to system clipboard",
                },
                ["ypr"] = {
                    copy_rel_path,
                    mode = "n",
                    desc = "Copy relative filepath to system clipboard",
                },
            },
            lsp_file_methods = {
                autosave_changes = true,
            },
            view_options = {
                show_hidden = true,
            },
            win_options = {
                wrap = true,
                signcolumn = "yes",
            },
        })

        keymap_normal("-", "<CMD>Oil<CR>", "OIL", true, "Open parent directory in oil")
    end,
}
