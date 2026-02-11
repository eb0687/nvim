-- NOTE: Custom grep
vim.api.nvim_create_user_command("Grep", function(opts)
    local query = opts.args
    if query and query ~= "" then
        vim.cmd("copen")
        vim.cmd("silent grep! " .. vim.fn.shellescape(query))
    else
        vim.notify("Usage: :Grep <search_term>")
    end
end, { nargs = "+" })
