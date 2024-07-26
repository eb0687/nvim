-- https://git.0x7be.net/dirk/neovim-config/src/commit/f2bd6aa9366f6aafc10210eca83c18b19c68cbe3/lua/plugins/lualine.lua#L49
local M = {}

M.get_permissions = function()
    local the_file = vim.fn.expand("%:p")
    local rw = vim.opt_local.readonly:get() == true and "r" or "rw"
    local x = vim.fn.executable(the_file) == 1 and "x" or ""
    local m = vim.api.nvim_buf_get_option(0, "modified") == true and "+" or ""
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
