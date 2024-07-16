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
        local lsp_servers = require("eb.utils.lualine-helpers.lsp-servers")
        local macro = require("eb.utils.lualine-helpers.macro")
        -- local cwd = require('eb.utils.lualine-helpers.cwd')
        -- local diff = require("eb.utils.lualine-helpers.git-diff")
        -- local branch = require("eb.utils.lualine-helpers.git-branch")
        local mode = require("eb.utils.lualine-helpers.mode")
        local diagnostics = require("eb.utils.lualine-helpers.diagnostics")
        local location = require("eb.utils.lualine-helpers.location")
        local custom_theme = require("eb.utils.lualine-helpers.themes.gruvbox-material-custom")
        local lazy_status = require("lazy.status")
        local harpoon = require("harpoon")
        local quickfix = require("eb.utils.lualine-helpers.quickfix")

        -- TODO: separate this function into lualinehelpers
        -- check for mason package upgrades
        -- https://github.com/williamboman/mason.nvim/discussions/1535
        local function lualine_mason_updates()
            local registry = require("mason-registry")
            local installed_packages = registry.get_installed_package_names()
            local upgrades_available = false
            local packages_outdated = 0
            local function myCallback(success, result_or_err)
                if success then
                    upgrades_available = true
                    packages_outdated = packages_outdated + 1
                end
            end

            for _, pkg in pairs(installed_packages) do
                local p = registry.get_package(pkg)
                if p then
                    p:check_new_version(myCallback)
                end
            end

            if upgrades_available then
                return packages_outdated
            else
                return ""
            end
        end

        -- TODO: separate this function into lualinehelpers
        local function harpoon_toggle()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end

        -- TODO: separate this function into lualinehelpers
        -- https://github.com/declancm/maximize.nvim?tab=readme-ov-file#-statusline--winbar
        local function maximize_status()
            return vim.t.maximized and "" or ""
        end

        -- TODO: separate this function into lualinehelpers
        -- NOTE: show modules based on the width of the window
        -- https://www.reddit.com/r/neovim/comments/u2uc4p/comment/i4myaxa/?utm_source=share&utm_medium=web2x&context=3
        local function min_window_width(width)
            return function()
                return vim.fn.winwidth(0) > width
            end
        end

        require("lualine").setup({
            sections = {
                lualine_a = {
                    {
                        mode,
                        padding = 1,
                        cond = min_window_width(40),
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
                        cond = min_window_width(0),
                    },
                    {
                        diagnostics,
                        cond = min_window_width(30),
                    },
                    { maximize_status },
                    macro,
                },
                lualine_x = {
                    { quickfix.counter },
                    {
                        lualine_mason_updates,
                        icon = "",
                        color = { fg = "#ea6962" },
                        on_click = function()
                            vim.cmd("Mason")
                        end,
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
                        cond = min_window_width(50),
                        on_click = function()
                            harpoon_toggle()
                        end,
                    },
                    -- harpoon_component,
                    -- {

                    --     branch,
                    --     padding = 1,
                    --     cond = min_window_width(40),
                    -- },
                    -- {
                    --     diff,
                    --     padding = 1,
                    --     cond = min_window_width(50),
                    -- },
                    -- {
                    --     diagnostics,
                    --     cond = min_window_width(30)
                    -- },
                },
                lualine_y = {
                    {
                        "filetype",
                        padding = 1,
                        cond = min_window_width(40),
                    },
                    {
                        location,
                        padding = 1,
                        cond = min_window_width(40),
                    },
                    {
                        lsp_servers,
                        padding = 1,
                        cond = min_window_width(50),
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
