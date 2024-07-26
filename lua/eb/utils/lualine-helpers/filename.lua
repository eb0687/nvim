local M = require("lualine.components.filename"):extend()
local highlight = require("lualine.highlight")
local default_status_colors = { saved = "#32302f", modified = "#d8a657", readonly = "#fb4934" }

function M:init(options)
    M.super.init(self, options)
    self.status_colors = {
        saved = highlight.create_component_highlight_group(
            { bg = default_status_colors.saved },
            "filename_status_saved",
            self.options
        ),
        modified = highlight.create_component_highlight_group(
            { fg = default_status_colors.modified },
            "filename_status_modified",
            self.options
        ),
        readonly = highlight.create_component_highlight_group(
            { fg = default_status_colors.readonly },
            "filename_status_readonly",
            self.options
        ),
    }
    if self.options.color == nil then
        self.options.color = ""
    end
end

function M:update_status()
    local data = M.super.update_status(self)
    local highlight_group = self.status_colors.saved
    if vim.bo.modified then
        highlight_group = self.status_colors.modified
    elseif vim.bo.readonly then
        highlight_group = self.status_colors.readonly
    end
    if data == "[No Name]" then
        highlight_group = self.status_colors.saved
    end
    data = highlight.component_format_highlight(highlight_group) .. data
    return data
end

return M
