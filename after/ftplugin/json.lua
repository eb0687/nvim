local set = vim.opt_local

set.tabstop = 2
set.shiftwidth = 2

-- NOTE: When creating a new line with o, make sure there is a trailing comma on the current line
-- SOURCE: https://github.com/JoosepAlviste/dotfiles/blob/c171efbbbe0daa5e737250ec82338a51ed53c15a/config/nvim/ftplugin/json.lua
-- SOURCE: https://medium.com/scoro-engineering/5-smart-mini-snippets-for-making-text-editing-more-fun-in-neovim-b55ffb96325a
vim.keymap.set("n", "o", function()
    local line = vim.api.nvim_get_current_line()

    local should_add_comma = string.find(line, "[^,{[]$")
    if should_add_comma then
        return "A,<cr>"
    else
        return "o"
    end
end, { buffer = true, expr = true })
