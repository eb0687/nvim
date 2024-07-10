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
        neogit.setup({
            commit_editor = {
                kind = "tab",
            },
        })
    end,
}
