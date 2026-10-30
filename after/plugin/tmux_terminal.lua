Tmux_pane_function = function()
    local pane_direction = vim.g.tmux_pane_direction or "bottom"
    local pane_size = (pane_direction == "right") and 30 or 15
    local move_key = (pane_direction == "right") and "C-l" or "C-k"
    local split_cmd = (pane_direction == "right") and "-h" or "-v"

    local buffer_path = vim.api.nvim_buf_get_name(0)
    local buffer_dir = buffer_path ~= "" and vim.fn.fnamemodify(buffer_path, ":h") or vim.fn.getcwd()
    local file_dir = vim.fs.root(buffer_dir, { ".git" }) or buffer_dir
    local escaped_dir = file_dir:gsub("'", "'\\''")

    local has_panes = vim.fn.system("tmux list-panes | wc -l"):gsub("%s+", "") ~= "1"
    local is_zoomed = vim.fn.system("tmux display-message -p '#{window_zoomed_flag}'"):gsub("%s+", "") == "1"

    if has_panes then
        vim.fn.system("tmux send-keys -t :.+ 'cd \"" .. escaped_dir .. "\"' Enter")
        if is_zoomed then
            vim.fn.system("tmux resize-pane -Z")
            vim.fn.system("tmux send-keys " .. move_key)
        else
            vim.fn.system("tmux resize-pane -Z")
        end
    else
        if vim.g.tmux_pane_dir == nil then
            vim.g.tmux_pane_dir = escaped_dir
        end
        vim.fn.system(
            "tmux split-window "
                .. split_cmd
                .. " -l "
                .. pane_size
                .. " -c '"
                .. escaped_dir
                .. "'"
                .. " 'cd \""
                .. escaped_dir
                .. "\" && DISABLE_PULL=1 zsh'"
        )
        vim.fn.system("tmux send-keys " .. move_key)
        vim.fn.system("tmux send-keys Escape i")
    end
end

vim.keymap.set({ "n", "v", "i" }, "<M-t>", function()
    Tmux_pane_function()
end, { desc = "Terminal on tmux pane (project root)" })
