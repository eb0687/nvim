local cmd = vim.cmd
local colorscheme = "gruvbox-material"

-- These configs must exist before running color scheme
cmd([[
    let g:gruvbox_material_enable_italic = 1
    let g:gruvbox_material_enable_bold = 1
    let g:gruvbox_material_background = ""
    let g:gruvbox_material_transparent_background = 1
    let g:gruvbox_material_visual = "red background"
    let g:gruvbox_material_menu_selection_background = "orange"
    let g:gruvbox_material_ui_contrast = "low"
    let g:gruvbox_material_diagnostic_text_highlight = 1
    let g:gruvbox_material_diagnostic_line_highlight = 1
    let g:gruvbox_material_diagnostic_virtual_text = "colored"
    let g:gruvbox_material_better_performance = 1
    let g:gruvbox_material_show_eob = 0
]])

-- Protected call incase the colorscheme is missing. This is to avoide NVIM from throwing errors at startup
-- SOURCE: https://youtu.be/RtNPfJKNr_8?list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end
