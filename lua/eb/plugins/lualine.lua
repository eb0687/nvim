--  _             _ _
-- | |_   _  __ _| (_)_ __   ___
-- | | | | |/ _` | | | '_ \ / _ \
-- | | |_| | (_| | | | | | |  __/
-- |_|\__,_|\__,_|_|_|_| |_|\___|
-- https://github.com/nvim-lualine/lualine.nvim

-- TODO:
-- migrate the new configs for lualine from my feat branch (on t490)

return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    config = function()
        local lsp_servers = require('eb.lualine-helpers.lsp-servers')
        local macro = require('eb.lualine-helpers.macro')
        local cwd = require('eb.lualine-helpers.cwd')
        local diff = require('eb.lualine-helpers.git-diff')
        local branch = require('eb.lualine-helpers.git-branch')
        local mode = require('eb.lualine-helpers.mode')
        local diagnostics = require('eb.lualine-helpers.diagnostics')
        local location = require('eb.lualine-helpers.location')
        local custom_theme = require('eb.lualine-helpers.themes.gruvbox-material-custom')

        -- NOTE: show modules based on the width of the window
        -- https://www.reddit.com/r/neovim/comments/u2uc4p/comment/i4myaxa/?utm_source=share&utm_medium=web2x&context=3
        local function min_window_width(width)
            return function()
                return vim.fn.winwidth(0) > width
            end
        end

        require('lualine').setup {
            sections = {
                lualine_a = {
                    {
                        mode,
                        padding = 1
                    }
                },
                lualine_b = {
                    {
                        branch,
                        padding = 1,
                        cond = min_window_width(30)
                    },
                    {
                        diff,
                        padding = 1,
                        cond = min_window_width(90)
                    }
                },
                lualine_c = {
                    {
                        cwd,
                        padding = 1,
                        cond = min_window_width(20)
                    }
                },
                lualine_x = {
                    macro,
                    {
                        diagnostics,
                        cond = min_window_width(30)
                    },
                },
                lualine_y = {
                    {
                        'filetype',
                        padding = 1,
                        cond = min_window_width(90)
                    },
                    {
                        location,
                        padding = 1,
                        cond = min_window_width(90)
                    },
                    {
                        lsp_servers,
                        padding = 1,
                        cond = min_window_width(100)
                    }
                },
                lualine_z = {
                },
            },
            options = {
                theme = custom_theme,
                -- component_separators = { left = '│', right = '│' },
                -- section_separators = { left = '│', right = '│' },
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    'NvimTree',
                },
            },
        }
        -- TEST:
        -- print("Hello from lazy lualine")
    end
}
