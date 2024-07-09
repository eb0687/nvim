-- Automatically rebalance windows when in a tmux session

-- Create an autocmd group to avoid duplication
local vim_resize = vim.api.nvim_create_augroup("AutoRebalanceWindows", { clear = true })

-- Define the autocmd for VimResized event
vim.api.nvim_create_autocmd("VimResized", {
    group = vim_resize,
    pattern = "*",
    command = "wincmd =",
})
