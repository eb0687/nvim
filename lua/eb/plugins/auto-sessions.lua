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

    keys = {
        {
            "<leader>wr",
            "<cmd>SessionRestore<CR>",
            desc = "AUTO SESSION: Restore session for cwd",
        },
        {
            "<leader>ws",
            "<cmd>SessionSave<CR>",
            desc = "AUTO SESSION: Save session for auto session root dir",
        },
        {
            "<leader>wl",
            "<cmd>Telescope session-lens<CR>",
            desc = "AUTO SESSION: List all sessions in Telescope",
        },
    },
}
