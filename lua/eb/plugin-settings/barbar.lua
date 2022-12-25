-- SOURCE: https://github.com/romgrk/barbar.nvim#lua-1
-- Barbar options
-- TODO: create a pcall for this plugin

require'bufferline'.setup{
    autohide = true,
    animation = false,
    closable = false,
    icon_separator_active = '',
    icon_separator_inactive = '',
    icon_pinned = '',
    insert_at_end = true
}
