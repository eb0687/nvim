-- neogit.nvim
-- https://github.com/NeogitOrg/neogit

return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local neogit = require("neogit")
        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_normal = custom_helpers.keymap_normal

        neogit.setup({
            commit_editor = {
                kind = "tab",
            },
        })

        keymap_normal("<leader>gc", ":Neogit commit<CR>", "NEOGIT", true, "Commit")
        keymap_normal("<leader>gl", ":Neogit log<CR>", "NEOGIT", true, "Log")
        keymap_normal("<leader>gP", ":Neogit push<CR>", "NEOGIT", true, "Push")
        keymap_normal("<leader>gF", ":Neogit fetch<CR>", "NEOGIT", true, "Fetch")
        keymap_normal("<leader>gp", ":Neogit pull<CR>", "NEOGIT", true, "Pull")
    end,
}
