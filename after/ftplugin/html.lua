local set = vim.opt_local

set.tabstop = 2
set.shiftwidth = 2

-- SOURCE: https://github.com/JoosepAlviste/dotfiles/blob/93f670c9b9d1972a8bc63f94698c4c0eec7c888a/config/nvim/ftplugin/vue.lua#L46
vim.keymap.set("i", "=", function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local left_of_cursor_range = { cursor[1] - 1, cursor[2] - 1 }

    -- The cursor location does not give us the correct node in this case, so we
    -- need to get the node to the left of the cursor
    local node = vim.treesitter.get_node({ pos = left_of_cursor_range })
    local nodes_active_in = { "attribute_name", "directive_argument", "directive_name" }
    if not node or not vim.tbl_contains(nodes_active_in, node:type()) then
        return "="
    end

    return '=""<left>'
end, { expr = true, buffer = true })
