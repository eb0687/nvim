vim.keymap.set("i", "=", function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local line = vim.api.nvim_get_current_line()
    local col = cursor[2]

    -- Get the text before the cursor
    local before_cursor = line:sub(1, col)

    -- Check if this is a standalone variable name or one after 'local'
    local valid_var_pattern = "^%s*[a-zA-Z_][a-zA-Z0-9_]*$"
    local valid_local_pattern = "^%s*local%s+[a-zA-Z_][a-zA-Z0-9_]*$"

    if before_cursor:match(valid_var_pattern) or before_cursor:match(valid_local_pattern) then
        return '=""<left>'
    end

    return "="
end, { expr = true, buffer = true })
