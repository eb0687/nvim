--              _
--  _ __   ___ (_) ___ ___
-- | '_ \ / _ \| |/ __/ _ \
-- | | | | (_) | | (_|  __/
-- |_| |_|\___/|_|\___\___|
-- https://github.com/folke/noice.nvim

return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        { "MunifTanjim/nui.nvim", lazy = true },
        -- "rcarriga/nvim-notify",
    },

    config = function()
        local noice = require("noice")

        -- NOTE: :h noice.nvim.txt for setup options
        noice.setup({
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = false,
                },
                hover = {
                    enabled = false,
                },
                signature = {
                    enabled = true,
                    auto_open = {
                        enabled = false,
                    },
                },
                progress = {
                    -- NOTE: disabling this as it causes alot of visual clutter
                    -- check docs for other options and usage
                    enabled = false,
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = false, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
            },
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        kind = "search_count",
                        -- find = "written",
                    },
                    opts = { skip = true },
                },
            },
            notify = {
                -- Noice can be used as `vim.notify` so you can route any notification like other messages
                -- Notification messages have their level and other properties set.
                -- event is always "notify" and kind can be any log level as a string
                -- The default routes will forward notifications to nvim-notify
                -- Benefit of using Noice for this is the routing and consistent history view
                enabled = false,
                view = "notify",
            },
            messages = {
                enabled = false,
                view = "messages",
            },
        })
    end,
}
