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
        -- These configs must exist before running color scheme
        vim.cmd([[
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

        vim.cmd([[colorscheme gruvbox-material]])

        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1D2021" })
        vim.api.nvim_set_hl(0, "FloatTitle", { bg = "#1D2021", fg = "#E78A4E" })
        vim.api.nvim_set_hl(0, "FloatFooter", { bg = "#1D2021" })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "#7DAEA3" })

        -- Flash.nvim
        vim.api.nvim_set_hl(0, "FlashBackdrop", { bg = "#191919", fg = "#665C54" })
        vim.api.nvim_set_hl(0, "FlashLabel", { bg = "#EA6962", fg = "#191919" })
        vim.api.nvim_set_hl(0, "FlashPrompt", { bg = "#EA6962", fg = "#191919" })
        vim.api.nvim_set_hl(0, "FlashPromptIcon", { bg = "#EA6962", fg = "#191919" })
        vim.api.nvim_set_hl(0, "FlashCurrent", { bg = "#EA6962" })

        -- Hydra
        vim.api.nvim_set_hl(0, "HydraPink", { bg = "#EA6962", fg = "#191919", bold = true })

        -- Mini Various
        vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { underline = true, fg = nil, bg = nil })
        vim.api.nvim_set_hl(0, "MiniCursorword", { underline = false, fg = nil, bg = nil })
        vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#84776A" })

        -- Mini Pick
        local statuline_colors = require("eb.utils.mini-helpers.colors")
        vim.api.nvim_set_hl(0, "MiniPickNormal", { bg = "" })
        vim.api.nvim_set_hl(0, "MiniPickPrompt", { bg = "#1D2021", fg = "#E78A4E" })
        vim.api.nvim_set_hl(0, "MiniPickPromptPrefix", { fg = "#32302F" })
        vim.api.nvim_set_hl(0, "MiniPickBorder", { fg = "#32302F" })
        vim.api.nvim_set_hl(0, "MiniPickBorderText", { bg = "#32302F", fg = "#E78A4E" })

        -- Mini Statusline
        vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", statuline_colors.main.normal)
        vim.api.nvim_set_hl(0, "MiniStatuslineFilename", statuline_colors.filename.normal)
        vim.api.nvim_set_hl(0, "MiniStatuslineFilenameModified", statuline_colors.filename.modified)
        vim.api.nvim_set_hl(0, "MiniStatuslineFilenameReadonly", statuline_colors.filename.read_only)
        vim.api.nvim_set_hl(0, "MiniStatuslineGit", statuline_colors.git)
        vim.api.nvim_set_hl(0, "MiniStatuslineMacro", statuline_colors.macro)
        vim.api.nvim_set_hl(0, "MiniStatuslineLocation", statuline_colors.location)
        vim.api.nvim_set_hl(0, "MiniStatuslineLsp", statuline_colors.lsp)
        vim.api.nvim_set_hl(0, "MiniStatusLineLazy", statuline_colors.lazy)
        vim.api.nvim_set_hl(0, "MiniStatusLineBufferCount", statuline_colors.buffer_count)
        vim.api.nvim_set_hl(0, "MiniStatuslineDiagError", statuline_colors.diagnostics.error)
        vim.api.nvim_set_hl(0, "MiniStatuslineDiagWarn", statuline_colors.diagnostics.warn)
        vim.api.nvim_set_hl(0, "MiniStatuslineDiffAdded", statuline_colors.diff.added)
        vim.api.nvim_set_hl(0, "MiniStatuslineDiffChanged", statuline_colors.diff.changed)
        vim.api.nvim_set_hl(0, "MiniStatuslineDiffRemoved", statuline_colors.diff.removed)
        vim.api.nvim_set_hl(0, "MiniStatulineReadonly", statuline_colors.permissions.read_only)
        vim.api.nvim_set_hl(0, "MiniStatuslineExecutable", statuline_colors.permissions.executable)
        vim.api.nvim_set_hl(0, "MiniStatuslineModified", statuline_colors.permissions.modifiable)
        vim.api.nvim_set_hl(0, "MiniStatusLineQfIcon", statuline_colors.qf.icon)
        vim.api.nvim_set_hl(0, "MiniStatusLineQfCount", statuline_colors.qf.count)
        vim.api.nvim_set_hl(0, "MiniStatuslineLineCount", statuline_colors.count.lines)
        vim.api.nvim_set_hl(0, "MiniStatuslineWordCount", statuline_colors.count.words)
        vim.api.nvim_set_hl(0, "MiniStatusLineCharCount", statuline_colors.count.chars)

        -- Blink
        vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#7daea3", bg = "", bold = true, italic = false })
        vim.api.nvim_set_hl(0, "BlinkCmpMenu", { fg = "", bg = "", bold = true, italic = false })
        vim.api.nvim_set_hl(0, "BlinkCmpSource", { fg = "", bg = "", bold = true, italic = false })
        vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { fg = "#32302f", bg = "#7daea3", bold = true, italic = false })
        vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#7daea3", bg = "", bold = true, italic = false })
        vim.api.nvim_set_hl(0, "BlinkCmpDoc", { fg = "", bg = "", bold = true, italic = false })
        vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { fg = "#89B482", bg = "", bold = true, italic = false })

        -- TODO: customize this later on as needed
        -- https://github.com/benomahony/oil-git.nvim
        -- Oil-git
        vim.api.nvim_set_hl(0, "OilGitModified", { fg = "#7daea3", bg = "", bold = true, italic = true })
        vim.api.nvim_set_hl(0, "OilGitAdded", { fg = "#a9b665", bg = "", bold = true, italic = true })

        -- Custom
        vim.api.nvim_set_hl(0, "Visual", { bg = "#d8a657", fg = "#191919", bold = true })
        vim.api.nvim_set_hl(0, "YankHi", { bg = "#d8a657", fg = "#191919", bold = true })

        vim.api.nvim_set_hl(0, "MyCursorLine", { fg = "#32302f", bg = "#7daea3", bold = true, italic = false })
        vim.api.nvim_set_hl(0, "MyBorder", { fg = "#7daea3", bg = "" })
    end,
}
