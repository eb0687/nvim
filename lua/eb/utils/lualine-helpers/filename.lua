local M = require("lualine.components.filename"):extend()
local highlight = require("lualine.highlight")
local default_status_colors = { saved = "#32302f", modified = "#fabd24" }

function M:init(options)
    M.super.init(self, options)
    self.status_colors = {
        saved = highlight.create_component_highlight_group(
            { bg = default_status_colors.saved },
            "filename_status_saved",
            self.options
        ),
        modified = highlight.create_component_highlight_group(
            -- { bg = default_status_colors.modified, fg = default_status_colors.fg_modified },
            { fg = default_status_colors.modified },
            "filename_status_modified",
            self.options
        ),
    }
    if self.options.color == nil then
        self.options.color = ""
    end
end

function M:update_status()
    local data = M.super.update_status(self)
    data = highlight.component_format_highlight(
        vim.bo.modified and self.status_colors.modified or self.status_colors.saved
    ) .. data
    return data
end

return M
