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
        require('lualine').setup {
            sections = {
                lualine_c = {
                    { 'filename', path = 1 },
                    'lsp_progress',
                },
            },
            options = {
                theme = 'gruvbox-material',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
            }
        }
        -- TEST:
        -- print("Hello from lazy lualine")
    end
}
