--  _             _ _
-- | |_   _  __ _| (_)_ __   ___
-- | | | | |/ _` | | | '_ \ / _ \
-- | | |_| | (_| | | | | | |  __/
-- |_|\__,_|\__,_|_|_|_| |_|\___|
-- https://github.com/nvim-lualine/lualine.nvim

return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
        -- local cwd = require('eb.utils.lualine-helpers.cwd')
        -- local diff = require("eb.utils.lualine-helpers.git-diff")
        -- local branch = require("eb.utils.lualine-helpers.git-branch")
        local lsp_servers = require("eb.utils.lualine-helpers.lsp-servers")
        local macro = require("eb.utils.lualine-helpers.macro")
        local mode = require("eb.utils.lualine-helpers.mode")
        local diagnostics = require("eb.utils.lualine-helpers.diagnostics")
        local location = require("eb.utils.lualine-helpers.location")
        local custom_theme = require("eb.utils.lualine-helpers.themes.gruvbox-material-custom")
        local lazy_status = require("lazy.status")
        local quickfix = require("eb.utils.lualine-helpers.quickfix")
        local mason_updates = require("eb.utils.lualine-helpers.mason-updates")
        local harpoon = require("eb.utils.lualine-helpers.harpoon-toggle")
        local maximize = require("eb.utils.lualine-helpers.maximize")
        local min_window_width = require("eb.utils.lualine-helpers.minimum-window-width")

        require("lualine").setup({
            sections = {
                lualine_a = {
                    {
                        mode,
                        padding = 1,
                        cond = min_window_width.min_window_width(50),
                    },
                },
                -- lualine_b = {
                -- {
                --     branch,
                --     padding = 1,
                --     cond = min_window_width(30)
                -- },
                -- {
                --     diff,
                --     padding = 1,
                --     cond = min_window_width(90)
                -- }
                -- },
                -- lualine_c = {
                --     {
                --         cwd,
                --         padding = 1,
                --         cond = min_window_width(20)
                --     }
                -- },
                lualine_c = {
                    {
                        "filename",
                        icon = {
                            "",
                            align = "left",
                            color = {
                                fg = "#7DAEA3",
                            },
                        },
                        file_status = true,
                        path = 3,
                        shorting_target = 30,
                        symbols = {
                            modified = "󱇧", -- Text to show when the file is modified.
                            readonly = "", -- Text to show when the file is non-modifiable or readonly.
                            unnamed = "Unammed", -- Text to show for unnamed buffers.
                            newfile = "New File", -- Text to show for newly created file before first write
                        },
                        cond = min_window_width.min_window_width(50),
                    },
                    {
                        diagnostics,
                        cond = min_window_width.min_window_width(30),
                    },
                    { maximize.maximize_status },
                    macro,
                },
                lualine_x = {
                    { quickfix.counter },
                    {
                        mason_updates.get_updates,
                        icon = "",
                        color = { fg = "#ea6962" },
                        on_click = function()
                            vim.cmd("Mason")
                        end,
                        cond = min_window_width.min_window_width(50),
                    },
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = "#ea6962" },
                        on_click = function()
                            vim.cmd("Lazy")
                        end,
                    },
                    {
                        "harpoon2",
                        padding = 1,
                        cond = min_window_width.min_window_width(50),
                        on_click = function()
                            harpoon.toggle()
                        end,
                    },
                    -- harpoon_component,
                    -- {

                    --     branch,
                    --     padding = 1,
                    --     cond = min_window_width.min_window_width(40),
                    -- },
                    -- {
                    --     diff,
                    --     padding = 1,
                    --     cond = min_window_width.min_window_width(50),
                    -- },
                    -- {
                    --     diagnostics,
                    --     cond = min_window_width.min_window_width(30)
                    -- },
                },
                lualine_y = {
                    {
                        "filetype",
                        padding = 1,
                        cond = min_window_width.min_window_width(50),
                    },
                    {
                        location,
                        padding = 1,
                        cond = min_window_width.min_window_width(50),
                    },
                    {
                        lsp_servers,
                        padding = 1,
                        cond = min_window_width.min_window_width(50),
                        on_click = function()
                            vim.cmd("LspInfo")
                        end,
                    },
                },
                lualine_z = {},
            },
            options = {
                theme = custom_theme,
                -- component_separators = { left = '│', right = '│' },
                -- section_separators = { left = '│', right = '│' },
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    "NvimTree",
                },
            },
        })
        -- TEST:
        -- print("Hello from lazy lualine")
    end,
}
