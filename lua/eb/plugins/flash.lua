--   __ _           _
--  / _| | __ _ ___| |__
-- | |_| |/ _` / __| '_ \
-- |  _| | (_| \__ \ | | |
-- |_| |_|\__,_|___/_| |_|
-- https://github.com/folke/flash.nvim

return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",

        ---@module "flash"
        opts = {
            labels = "asdfqwerzxcv", -- Limit labels to left side of the keyboard
            modes = {
                char = {
                    enabled = true,
                    jump_labels = true,
                },
            },
            search = {
                enabled = false,
            },
        },

        keys = {
            {
                "s",
                mode = { "n", "o", "x" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "R",
                mode = "o",
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Treesitter search",
            },
            {
                "r",
                mode = { "o" },
                function()
                    require("flash").remote()
                end,
                desc = "Remote flash",
            },
            -- {
            --     "<c-s>",
            --     mode = { "c" },
            --     function()
            --         require("flash").toggle()
            --     end,
            --     desc = "Toggle Flash Search",
            -- },
        },

        config = function(_, opts)
            local custom_helpers = require("eb.utils.custom_helpers")
            local keymap_silent = custom_helpers.keymap_silent
            local flash_word = function()
                require("flash").jump({
                    pattern = vim.fn.expand("<cword>"),
                })
            end

            local flash_treesitter = function()
                require("flash").treesitter_search()
            end

            local flash_toggle = function()
                require("flash").toggle()
            end

            local flash_diagnostic = function()
                require("flash").jump({
                    matcher = function(win)
                        return vim.tbl_map(function(diag)
                            return {
                                pos = { diag.lnum + 1, diag.col },
                                end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
                            }
                        end, vim.diagnostic.get(vim.api.nvim_win_get_buf(win)))
                    end,
                    action = function(match, state)
                        vim.api.nvim_win_call(match.win, function()
                            vim.api.nvim_win_set_cursor(match.win, match.pos)
                            vim.diagnostic.open_float()
                        end)
                        state:restore()
                    end,
                })
            end

            local flash_continue = function()
                require("flash").jump({ continue = true })
            end

            keymap_silent("n", "<leader>fw", flash_word, "Flash word")
            keymap_silent("n", "<leader>ft", flash_treesitter, "Flash treesitter")
            keymap_silent("n", "<leader>fd", flash_diagnostic, "Flash diagnostics")
            keymap_silent("n", "<leader>fl", flash_continue, "Flash continue last search")
            keymap_silent("c", "<C-s>", flash_toggle, "Flash toggle")

            require("flash").setup(opts)
        end,
    },
}
