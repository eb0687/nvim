Tmux_pane_function = function()
    local auto_cd_to_new_dir = false
    local pane_direction = vim.g.tmux_pane_direction or "bottom"
    local pane_size = (pane_direction == "right") and 30 or 15
    local move_key = (pane_direction == "right") and "C-l" or "C-k"
    local split_cmd = (pane_direction == "right") and "-h" or "-v"

    -- Use git root if possible, fallback to cwd
    local file_dir = vim.fn.systemlist("git rev-parse --show-toplevel")[1] or vim.fn.getcwd()
    local escaped_dir = file_dir:gsub("'", "'\\''")

    local has_panes = vim.fn.system("tmux list-panes | wc -l"):gsub("%s+", "") ~= "1"
    local is_zoomed = vim.fn.system("tmux display-message -p '#{window_zoomed_flag}'"):gsub("%s+", "") == "1"

    if has_panes then
        if is_zoomed then
            if auto_cd_to_new_dir and vim.g.tmux_pane_dir ~= escaped_dir then
                vim.fn.system("tmux send-keys -t :.+ 'cd \"" .. escaped_dir .. "\"' Enter")
                vim.g.tmux_pane_dir = escaped_dir
            end
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
