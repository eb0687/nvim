require('lualine').setup{
    -- https://dev.to/arunanshub/making-a-proper-initlua-for-real-this-time-4k44
    sections = {
        lualine_c = {
            {'filename', path = 1},
            'lsp_progress',
        },
    },
    options = {
        theme = 'gruvbox-material',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
    }
}
