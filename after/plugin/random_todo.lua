local function random_todo()
    vim.cmd("vimgrep /\\cTODO:/g **/*")
    local qf = vim.fn.getqflist()
    local count = #qf
    if count == 0 then
        print("No TODOs found")
        return
    end

    local entry = qf[math.random(count)]

    -- prefer bufnr if present, else fallback to filename
    local buf = entry.bufnr > 0 and entry.bufnr or vim.fn.bufadd(entry.filename)
    vim.api.nvim_set_current_buf(buf)

    -- make sure line exists in buffer
    local line_count = vim.api.nvim_buf_line_count(buf)
    local lnum = math.min(entry.lnum, line_count)
    local col = math.max(0, entry.col - 1)

    vim.api.nvim_win_set_cursor(0, { lnum, col })
end

vim.api.nvim_create_user_command("RandomTodo", random_todo, {
    force = true,
    nargs = "*",
    desc = "Go to random TODO",
})
