local mode_highlights = {
    -- NormalMode = { source = "MiniStatuslineModeNormal", color = "fg" },
    InsertMode = { source = "MiniStatuslineModeInsert", color = "bg" },
    VisualMode = { source = "MiniStatuslineModeVisual", color = "bg" },
    SelectMode = { source = "MiniStatuslineModeVisual", color = "bg" },
    ReplaceMode = { source = "MiniStatuslineModeReplace", color = "bg" },
    CommandMode = { source = "MiniStatuslineModeCommand", color = "bg" },
    TerminalMode = { source = "MiniStatuslineModeOther", color = "bg" },
    TerminalNormalMode = { source = "MiniStatuslineModeOther", color = "bg" },
}

local function sync_mode_highlights()
    for target, config in pairs(mode_highlights) do
        local source = vim.api.nvim_get_hl(0, {
            name = config.source,
            link = false,
        })
        local color = source[config.color]

        if color then
            vim.api.nvim_set_hl(0, target, {
                fg = color,
                bold = true,
            })
        end
    end

    local modicator = require("modicator")
    local current_mode = vim.api.nvim_get_mode().mode
    modicator.set_cursor_line_highlight(modicator.hl_name_from_mode(current_mode))
end

return {
    "mawkler/modicator.nvim",
    init = function()
        -- These are required for Modicator to work
        vim.o.cursorline = true
        vim.o.number = true
        vim.o.termguicolors = true
    end,
    opts = {
        -- Warn if any required option above is missing. May emit false positives
        -- if some other plugin modifies them, which in that case you can just
        -- ignore. Feel free to remove this line after you've gotten Modicator to
        -- work properly.
        show_warnings = true,
    },
    config = function(_, opts)
        require("modicator").setup(opts)

        vim.api.nvim_create_autocmd("ColorScheme", {
            group = vim.api.nvim_create_augroup("SyncModicatorHighlights", {
                clear = true,
            }),
            callback = sync_mode_highlights,
        })

        sync_mode_highlights()
    end,
}
