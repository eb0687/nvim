-- https://git.0x7be.net/dirk/neovim-config/src/commit/f2bd6aa9366f6aafc10210eca83c18b19c68cbe3/lua/plugins/lualine.lua#L49
local M = {}
local highlight = vim.api.nvim_set_hl
-- Define highlight groups
highlight(0, "MyHighlightReadOnly", require("eb.utils.mini-helpers.colors").permissions.read_only)
highlight(0, "MyHighlightExecutable", require("eb.utils.mini-helpers.colors").permissions.executable)
highlight(0, "MyHighlightModified", require("eb.utils.mini-helpers.colors").permissions.modifiable)
-- Helper function to apply highlight
local function apply_highlight(group, text)
    return "%#" .. group .. "#" .. text
end
M.get_permissions = function()
    if not M.filetype() then
        return ""
    end

    local the_file = vim.fn.expand("%:p")
    local rw = vim.opt_local.readonly:get() == true and apply_highlight("MyHighlightReadOnly", "r")
        or apply_highlight("MyHighlightReadOnly", "rw")
    local x = vim.fn.executable(the_file) == 1 and apply_highlight("MyHighlightExecutable", "x") or ""
    -- local m = vim.api.nvim_buf_get_option(0, "modified") == true and apply_highlight("MyHighlightModified", "+") or ""
    local m = vim.bo.modified == true and apply_highlight("MyHighlightModified", "+") or ""
    return the_file == "" and "" .. m or rw .. x .. m
end

M.filetype = function()
    local ft = vim.opt_local.filetype:get()
    local count = {
        bash = true,
        sh = true,
        zsh = true,
    }
    return count[ft] ~= nil
end
return M
