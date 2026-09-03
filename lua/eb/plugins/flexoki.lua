---@class FlexokiColors: ColorScheme
---@field paper string
---@field black string
---@field red string
---@field orange string
---@field yellow string
---@field green string
---@field teal string
---@field blue string
---@field blue1 string
---@field purple string
---@field magenta string
return {
    "emiara/flexoki.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("flexoki").setup({
            on_highlights = function(hl, c)
                ---@cast c FlexokiColors
                -- Mini Statusline
                hl.MiniStatuslineFilename = { fg = c.paper }
                hl.MiniStatuslineFilenameModified = { fg = c.green }
                hl.MiniStatuslineFilenameReadonly = { fg = c.red }
                hl.MiniStatuslineGit = { fg = c.blue1 }
                hl.MiniStatuslineMacro = { fg = c.red }
                hl.MiniStatuslineLsp = { fg = c.blue }
                hl.MiniStatuslineBufferCount = { fg = c.green }
                hl.MiniStatuslineDiagError = { fg = c.red }
                hl.MiniStatuslineDiagWarn = { fg = c.yellow }
                hl.MiniStatuslineDiffAdded = { fg = c.green }
                hl.MiniStatuslineDiffChanged = { fg = c.teal }
                hl.MiniStatuslineDiffRemoved = { fg = c.red }
                hl.MiniStatuslineReadonly = { fg = c.red }
                hl.MiniStatusLineLazy = { fg = c.teal }
                hl.MiniStatuslineModified = { fg = c.yellow }
                hl.MiniStatuslineQfIcon = { fg = c.purple }
                hl.MiniStatuslineLineCount = { fg = c.teal }
                hl.MiniStatuslineWordCount = { fg = c.blue }
                hl.MiniStatuslineCharCount = { fg = c.purple }
                -- Blink
                hl.BlinkCmpMenuBorder = { fg = c.teal }
                hl.BlinkCmpMenuSelection = { bg = c.teal, fg = c.black }
                hl.BlinkCmpDocBorder = { fg = c.teal }
                hl.BlinkCmpSignatureHelpBorder = { fg = c.teal }
                -- Oil-Git
                hl.OilGitAdded = { fg = c.green }
                hl.OilGitModified = { fg = c.yellow }
                hl.OilGitUntracked = { fg = c.red }
                -- Custom
                hl.Visual = { fg = c.black, bg = c.yellow }
                hl.YankHi = { fg = c.black, bg = c.yellow }
                hl.MyCursorLine = { fg = c.black, bg = c.yellow }
                hl.MyBorder = { fg = c.yellow }
            end,
        })
    end,
}
