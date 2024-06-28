--         _ _       _
--    __ _(_) |_ ___(_) __ _ _ __  ___
--   / _` | | __/ __| |/ _` | '_ \/ __|
--  | (_| | | |_\__ \ | (_| | | | \__ \
--  \__, |_|\__|___/_|\__, |_| |_|___/
--  |___/             |___/
-- https://github.com/lewis6991/gitsigns.nvim

return {
    'lewis6991/gitsigns.nvim',

    -- load plugin only when git directory available
    -- https://github.com/folke/lazy.nvim/discussions/994
    -- cond = vim.fn.isdirectory('.git') == 1,

    config = function()
        local gitsigns = require('gitsigns')

        -- SETUP
        gitsigns.setup({
            -- signs = {
            --     add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
            --     change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
            --     delete = { hl = "GitSignsDelete", text = "▎", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
            --     topdelete = {
            --         hl = "GitSignsDelete",
            --         text = " ",
            --         numhl = "GitSignsDeleteNr",
            --         linehl = "GitSignsDeleteLn"
            --     },
            --     changedelete = {
            --         hl = "GitSignsChange",
            --         text = "▎",
            --         numhl = "GitSignsChangeNr",
            --         linehl = "GitSignsChangeLn"
            --     },
            -- },
            signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
            linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
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
            -- yadm = {
            --     enable = false,
            -- },
        })

        -- KEYMAPS
        local keymap = function(keys, func, desc)
            if desc then
                desc = 'GitSigns: ' .. desc
            end

            vim.keymap.set('n', keys, func, { desc = desc })
        end

        keymap("]g", ":Gitsigns next_hunk<CR>", "next hunk")
        keymap("[g", ":Gitsigns prev_hunk<CR>", "previous hunk")

        keymap("<leader>gp", ":Gitsigns preview_hunk<CR>", "preview hunk")
        keymap("<leader>gs", ":Gitsigns stage_hunk<CR>", "stage hunk")
        keymap("<leader>gu", ":Gitsigns undo_stage_hunk<CR>", "undo stage hunk")

        keymap("<leader>gS", ":Gitsigns stage_buffer<CR>", "stage buffer")
        keymap("<leader>gU", ":Gitsigns reset_buffer<CR>", "reset buffer")

        -- TEST:
        -- print("Hello from lazy gitsigns")
    end
}
