-- auto-session.nvim
-- https://github.com/rmagatti/auto-session

return {
    "rmagatti/auto-session",
    dependencies = {
        "nvim-telescope/telescope.nvim", -- :Telescope session-lens
    },
    config = function()
        local auto_session = require("auto-session")
        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_normal = custom_helpers.keymap_normal

        auto_session.setup({
            auto_session_create_enabled = true,
            auto_save_enabled = true,
            auto_restore_enabled = false,
            auto_session_suppress_dirs = {
                "~/Downloads",
                "~/Documents",
            },
        })

        keymap_normal(
            "<leader>ws",
            "<cmd>SessionSave<CR>",
            "AUTO SESSION",
            true,
            "Save session for auto session root dir"
        ) -- save workspace session for current working directory
        keymap_normal(
            "<leader>wl",
            require("auto-session.session-lens").search_session,
            "List all sessions in Telescope"
        )
    end,
}
