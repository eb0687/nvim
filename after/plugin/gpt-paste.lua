vim.api.nvim_create_user_command("GPTPaste", function(opts)
    vim.cmd(string.format("%d,%dyank +", opts.line1, opts.line2))
    vim.fn.jobstart({ vim.fn.expand("~/.local/bin/gpt-paste") }, {
        detach = true,
    })
end, { range = true })
