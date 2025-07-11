--    ___ ___ | | ___  _ __ ___  ___| |__   ___ _ __ ___   ___
--   / __/ _ \| |/ _ \| '__/ __|/ __| '_ \ / _ \ '_ ` _ \ / _ \
--  | (_| (_) | | (_) | |  \__ \ (__| | | |  __/ | | | | |  __/
--   \___\___/|_|\___/|_|  |___/\___|_| |_|\___|_| |_| |_|\___|

-- gruvbox-material
-- https://github.com/sainnhe/gruvbox-material
return {
    "sainnhe/gruvbox-material", -- gruvbox material colorscheme
    priority = 1000,
    lazy = false,
    config = function()
        local cmd = vim.cmd
        local nvim_set_hl = vim.api.nvim_set_hl

        -- These configs must exist before running color scheme
        cmd([[
            let g:gruvbox_material_enable_italic = 1
            let g:gruvbox_material_enable_bold = 1
            let g:gruvbox_material_background = ""
            let g:gruvbox_material_transparent_background = 1
            let g:gruvbox_material_visual = "green background"
            let g:gruvbox_material_menu_selection_background = "orange"
            let g:gruvbox_material_ui_contrast = "low"
            let g:gruvbox_material_diagnostic_text_highlight = 1
            let g:gruvbox_material_diagnostic_line_highlight = 1
            let g:gruvbox_material_diagnostic_virtual_text = "colored"
            let g:gruvbox_material_better_performance = 1
            let g:gruvbox_material_show_eob = 0
        ]])

        cmd([[colorscheme gruvbox-material]])

        -- TODO: is this the best way to customize for various plugins?
        -- look up alternative solutions that allow for easier manipulation
        -- of colors

        -- NOTE: Harpoon2

        -- nvim_set_hl(0, "NormalFloat", { bg = "#1D2021" })
        nvim_set_hl(0, "NormalFloat", { bg = "#252423" })
        nvim_set_hl(0, "FloatTitle", { bg = "#1D2021", fg = "#E78A4E" })
        nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "#7DAEA3" })

        -- Flash.nvim
        nvim_set_hl(0, "FlashBackdrop", { bg = "#191919", fg = "#665C54" })
        nvim_set_hl(0, "FlashLabel", { bg = "#EA6962", fg = "#191919" })
        nvim_set_hl(0, "FlashPrompt", { bg = "#EA6962", fg = "#191919" })
        nvim_set_hl(0, "FlashPromptIcon", { bg = "#EA6962", fg = "#191919" })
        nvim_set_hl(0, "FlashCurrent", { bg = "#EA6962" })

        -- Hydra
        nvim_set_hl(0, "HydraPink", { bg = "#EA6962", fg = "#191919", bold = true })

        -- NOTE: disabling the below as nvim-cmp is no longer being used, replaced with blink
        -- -- CMP
        -- -- gray
        -- nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })
        -- -- blue
        -- nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#E78A4E" })
        -- nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })
        -- -- light blue
        -- nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#EA6962" })
        -- nvim_set_hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
        -- nvim_set_hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
        -- -- pink
        -- nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#89B482" })
        -- nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
        -- -- front
        -- nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#7DAEA3" })
        -- nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
        -- nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })

        -- Lspsaga
        nvim_set_hl(0, "ActionPreviewTitle", { bg = "#32302f", fg = "#89B482" })
        nvim_set_hl(0, "SagaText", { bg = "#32302f", fg = "#EA6962" })
        nvim_set_hl(0, "HoverBorder", { bg = "#32302f" })
        nvim_set_hl(0, "HoverNormal", { bg = "#32302f", fg = "#EA6962" })

        -- Muticursors
        nvim_set_hl(0, "Multicursor", { bg = "#32302F", fg = "#EA6962", default = true })
        nvim_set_hl(0, "MulticursorMain", { bg = "#32302F", fg = "#EA6962", bold = true, default = true })

        -- NOTE: no longer using barbar
        -- barbar
        -- nvim_set_hl(0, "BufferCurrent", { bg = "#252423", fg = "#E78A4E" })
        -- nvim_set_hl(0, "BufferVisible", { bg = "#252423", fg = "#84776A" })
        -- nvim_set_hl(0, "BufferInactive", { bg = "#252423", fg = "#84776A" })

        -- Mini
        -- nvim_set_hl(0, "MiniCursorwordCurrent", { bg = "#84776A", fg = "#000000" })
        vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { underline = true, fg = nil, bg = nil })
        vim.api.nvim_set_hl(0, "MiniCursorword", { underline = false, fg = nil, bg = nil })
        nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#84776A" })

        -- Blink
        nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#7daea3", bg = "", bold = true, italic = false })
        nvim_set_hl(0, "BlinkCmpMenu", { fg = "", bg = "", bold = true, italic = false })
        nvim_set_hl(0, "BlinkCmpSource", { fg = "", bg = "", bold = true, italic = false })
        nvim_set_hl(0, "BlinkCmpMenuSelection", { fg = "#32302f", bg = "#7daea3", bold = true, italic = false })
        nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#7daea3", bg = "", bold = true, italic = false })
        nvim_set_hl(0, "BlinkCmpDoc", { fg = "", bg = "", bold = true, italic = false })
        nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { fg = "#89B482", bg = "", bold = true, italic = false })

        -- Custom
        nvim_set_hl(0, "YankHi", { fg = "#191919", bg = "#d4869b", bold = true, italic = false })
        nvim_set_hl(0, "Visual", { bg = "#d3869b", fg = "#191919" })

        vim.api.nvim_set_hl(0, "MyCursorLine", { fg = "#32302f", bg = "#7daea3", bold = true, italic = false })
        vim.api.nvim_set_hl(0, "MyBorder", { fg = "#7daea3", bg = "" })

        -- TEST:
        -- print('Hello from colorscheme lazy')
    end,
}
