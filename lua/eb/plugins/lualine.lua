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
        -- local branch = require("eb.utils.lualine-helpers.git-branch")
        -- local selection_count = require("eb.utils.lualine-helpers.selection-count")
        -- local diff_source = require("eb.utils.lualine-helpers.git-diff")
        -- local lsp_servers = require("eb.utils.lualine-helpers.lsp-servers")
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
        local filename_color_status = require("eb.utils.lualine-helpers.filename")
        local word_count = require("eb.utils.lualine-helpers.word-count")
        local permissions = require("eb.utils.lualine-helpers.permissions")
        local lint_progress = require("eb.utils.lualine-helpers.lint-progress")
        local buffer_count = require("eb.utils.lualine-helpers.buffer-count")
        local copilot_helper = require("eb.utils.lualine-helpers.copilot-helpers")
        -- local telescope_helper = require("eb.utils.telescope-helpers")

        require("lualine").setup({
            sections = {
                lualine_a = {
                    {
                        mode,
                        padding = 1,
                        cond = min_window_width.min_window_width(80),
                    },
                },
                lualine_b = {
                    {
                        "branch",
                        icon = "",
                        color = { fg = "#7DAEA3" },
                        -- {
                        --     "diff",
                        --     source = diff_source,
                        -- },
                        cond = min_window_width.min_window_width(80),
                    },
                },
                lualine_c = {
                    {
                        filename_color_status,
                        "filename",
                        -- icon = {
                        --     "",
                        --     align = "left",
                        --     color = {
                        --         fg = "#7DAEA3",
                        --     },
                        -- },
                        file_status = true,
                        path = 3,
                        shorting_target = 30,
                        symbols = {
                            modified = "󱇧", -- Text to show when the file is modified.
                            readonly = "", -- Text to show when the file is non-modifiable or readonly.
                            unnamed = "Unammed", -- Text to show for unnamed buffers.
                            newfile = "New File", -- Text to show for newly created file before first write
                        },
                    },
                    {
                        permissions.get_permissions,
                        cond = permissions.filetype,
                        color = { fg = "#ea6962" },
                    },
                    diagnostics,
                    {
                        word_count.word_count,
                        cond = word_count.filetype,
                    },
                    { maximize.maximize_status },
                    macro,
                },
                lualine_x = {
                    {
                        "harpoon2",
                        icon = "",
                        cond = min_window_width.min_window_width(80),
                        on_click = function()
                            harpoon.toggle()
                        end,
                    },
                    {
                        quickfix.counter,
                        cond = min_window_width.min_window_width(80),
                    },
                    {
                        buffer_count.count_buffers,
                        cond = min_window_width.min_window_width(80),
                        -- on_click = function()
                        -- telescope_helper.buffer_searcher()
                        -- end,
                    },
                    {
                        mason_updates.get_updates,
                        icon = "",
                        color = { fg = "#ea6962" },
                        on_click = function()
                            vim.cmd("Mason")
                        end,
                        cond = min_window_width.min_window_width(80),
                    },
                    {
                        lazy_status.updates,
                        cond = function()
                            return lazy_status.has_updates() or min_window_width.min_window_width(80)
                        end,
                        color = { fg = "#ea6962" },
                        on_click = function()
                            vim.cmd("Lazy")
                        end,
                    },
                },
                lualine_y = {
                    -- {
                    --     "filetype",
                    --     padding = 1,
                    --     cond = min_window_width.min_window_width(80),
                    -- },
                    {

                        location,
                        padding = 1,
                        cond = min_window_width.min_window_width(80),
                        icon = false,
                    },
                    -- {
                    --     lsp_servers,
                    --     padding = 1,
                    --     cond = min_window_width.min_window_width(80),
                    --     on_click = function()
                    --         vim.cmd("LspInfo")
                    --     end,
                    --     icon = false,
                    -- },
                    {
                        "copilot",
                        symbols = {
                            hl = {
                                enabled = "#50FA7B",
                                sleep = "#AEB7D0",
                                disabled = "#6272A4",
                                warning = "#FFB86C",
                                unknown = "#FF5555",
                            },
                        },
                        show_colors = true,
                        padding = 1,
                        on_click = function()
                            copilot_helper.toggle_copilot()
                        end,
                        cond = min_window_width.min_window_width(80),
                    },
                },
                lualine_z = {
                    {
                        lint_progress.lint_progress,
                        padding = 1,
                        cond = min_window_width.min_window_width(80),
                    },
                },
            },
            options = {
                theme = custom_theme,
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    "NvimTree",
                },
            },
        })
    end,
}
