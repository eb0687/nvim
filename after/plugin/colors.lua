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

local keymap = function(keys, func, desc)
    if desc then
        desc = 'COLORSCHEME: ' .. desc
    end

    vim.keymap.set('n', keys, func, { desc = desc })
end

-- CUSTOM FUNCS
-- TODO: Maybe move this to the keymaps file or somewhere else which makes sense
function Background_On()
    vim.o.termguicolors = true
    vim.api.nvim_set_hl(0, "Normal", { bg = "#1d2021" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1d2021" })
end

function Background_Off()
    vim.o.termguicolors = true
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

function True_Zen_Minimal()
    require('true-zen.minimalist').toggle()
    cmd('silent !tmux set-option -g status')
end

function Toggle_Alacritty_Opacity()
    cmd('silent !toggle-alacritty-opacity')
end

local toggle = true
function Background_Toggle()
    if toggle then
        True_Zen_Minimal()
        -- Background_Off()
        toggle = false
    else
        -- Background_On()
        Toggle_Alacritty_Opacity()
        toggle = true
    end
end

-- Bindings
keymap('<leader>zz', Background_Toggle, 'Toggle Zen mode / Background')
