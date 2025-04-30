--         _ _       _
--    __ _(_) |_ ___(_) __ _ _ __  ___
--   / _` | | __/ __| |/ _` | '_ \/ __|
--  | (_| | | |_\__ \ | (_| | | | \__ \
--  \__, |_|\__|___/_|\__, |_| |_|___/
--  |___/             |___/
-- https://github.com/lewis6991/gitsigns.nvim

return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },

    -- load plugin only when git directory available
    -- https://github.com/folke/lazy.nvim/discussions/994
    -- cond = vim.fn.isdirectory('.git') == 1,

    config = function()
        local gitsigns = require("gitsigns")
        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_normal = custom_helpers.keymap_normal

        -- SETUP
        gitsigns.setup({
            signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
                interval = 1000,
                follow_files = true,
            },
            attach_to_untracked = true,
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            -- current_line_blame_formatter_opts = {
            --     relative_time = false,
            -- },
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            max_file_length = 40000,
            preview_config = {
                -- Options passed to nvim_open_win
                border = "single",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1,
            },
            trouble = false,
        })

        keymap_normal("]g", ":Gitsigns next_hunk<CR>", "GITSIGNS", true, "next hunk")
        keymap_normal("[g", ":Gitsigns prev_hunk<CR>", "GITSIGNS", true, "previous hunk")

        keymap_normal("<leader>gp", ":Gitsigns preview_hunk<CR>", "GITSIGNS", true, "preview hunk")
        keymap_normal("<leader>gs", ":Gitsigns stage_hunk<CR>", "GITSIGNS", true, "stage hunk")
        keymap_normal("<leader>gu", ":Gitsigns undo_stage_hunk<CR>", "GITSIGNS", true, "undo stage hunk")

        keymap_normal("<leader>gS", ":Gitsigns stage_buffer<CR>", "GITSIGNS", true, "stage buffer")
        keymap_normal("<leader>gU", ":Gitsigns reset_buffer<CR>", "GITSIGNS", true, "reset buffer")
        keymap_normal("<leader>gd", ":Gitsigns diffthis<CR>", "GITSIGNS", true, "diff this")

        -- text objext to select within a git hunk
        -- source: https://github.com/lewis6991/gitsigns.nvim?tab=readme-ov-file#-features
        vim.keymap.set({ "o", "x" }, "ih", "<Cmd>Gitsigns select_hunk<CR>")

        -- TEST:
        -- print("Hello from lazy gitsigns")
    end,
}
