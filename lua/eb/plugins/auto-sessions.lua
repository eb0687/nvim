-- auto-session.nvim
-- https://github.com/rmagatti/auto-session

return {
    "rmagatti/auto-session",
    config = function()
        local auto_session = require("auto-session")

        auto_session.setup({
            auto_restore_enabled = false,
            auto_session_suppress_dirs = {
                "~/Downloads",
                "~/Documents",
            },
        })

        local keymap = function(keys, func, desc)
            if desc then
                desc = "AUTO-SESSION: " .. desc
            end

            vim.keymap.set("n", keys, func, { desc = desc })
        end

        keymap("<leader>wr", "<cmd>SessionRestore<CR>", "Restore session for cwd") -- restore last workspace session for current directory
        keymap("<leader>ws", "<cmd>SessionSave<CR>", "Save session for auto session root dir") -- save workspace session for current working directory
    end,
}
