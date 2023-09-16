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
                        padding = 1
                    },
                    {
                        diff,
                        padding = 1
                    }
                },
                lualine_c = {
                    {
                        cwd,
                        padding = 1
                    }
                },
                lualine_x = {
                    macro,
                    diagnostics,
                },
                lualine_y = {
                    {
                        'filetype',
                        padding = 1
                    },
                    {
                        location,
                        padding = 1
                    },
                    {
                        lsp_servers,
                        padding = 1
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
