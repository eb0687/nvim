-- source: https://github.com/MariaSolOs/dotfiles/blob/62284b49d5a3428f33c3622d6b2a0a9590931c80/.config/nvim/lua/commands.lua
-- NOTE: open a scratch buffer
vim.api.nvim_create_user_command("Scratch", function()
    -- vim.cmd("bel 10new")
    vim.cmd("rightbelow vnew")
    local buf = vim.api.nvim_get_current_buf()
    for name, value in pairs({
        filetype = "scratch",
        buftype = "nofile",
        bufhidden = "wipe",
        swapfile = false,
        modifiable = true,
    }) do
        vim.api.nvim_set_option_value(name, value, { buf = buf })
    end
end, { desc = "Open a scratch buffer", nargs = 0 })
