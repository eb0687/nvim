-- auto-session.nvim
-- https://github.com/rmagatti/auto-session

return {
    "rmagatti/auto-session",
    lazy = false,
    dependencies = {
        "nvim-telescope/telescope.nvim", -- :Telescope session-lens
    },

    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
        auto_create = true,
        auto_save = true,
        auto_restore = false,
        suppressed_dirs = {
            "~/Downloads",
            "~/Documents",
        },
    },

    config = function(_, opts)
        local auto_session = require("auto-session")
        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_normal = custom_helpers.keymap_normal

        auto_session.setup(opts)

        keymap_normal("<leader>wr", "<cmd>SessionRestore<CR>", "AUTO SESSION", true, "Restore session for cwd")
        keymap_normal(
            "<leader>ws",
            "<cmd>SessionSave<CR>",
            "AUTO SESSION",
            true,
            "Save session for auto session root dir"
        )
        keymap_normal(
            "<leader>wl",
            require("auto-session.session-lens").search_session,
            "AUTO SESSION",
            true,
            "List all sessions in Telescope"
        )
    end,
}
