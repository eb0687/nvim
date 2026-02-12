vim.api.nvim_create_user_command("YankCodeBlock", function(opts)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)

    local start_line = opts.line1
    local end_line = opts.line2
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

    if #lines == 0 then
        vim.notify("No lines selected!", vim.log.levels.WARN)
        return
    end

    local code_block = table.concat(lines, "\n")
    local filetype = vim.bo.filetype
    local markdown = string.format("```%s\n%s\n```", filetype, code_block)

    vim.fn.setreg("+", markdown)
    vim.notify("Copied selected lines as markdown code block", vim.log.levels.INFO)
end, {
    range = true,
    desc = "Yank file as markdown code block",
})
