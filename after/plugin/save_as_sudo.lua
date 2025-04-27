-- NOTE: workaround for saving files as root using pkexec
-- when using something like :w !sudo tee % neovim would hang as it expects a password
-- SOURCE: https://github.com/neovim/neovim/issues/12103#issuecomment-2564170743

-- Define :SudoW command to save the file using pkexec and force reload
vim.api.nvim_create_user_command("SudoW", function()
    vim.cmd("silent! w !pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY tee % >/dev/null") -- Save file using pkexec
    vim.cmd("edit!") -- Force reload the file
end, {})

-- Define :SudoWq command to save the file using pkexec and quit
vim.api.nvim_create_user_command("SudoWq", function()
    vim.cmd("silent! w !pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY tee % >/dev/null") -- Save file using pkexec
    vim.cmd("edit!") -- Force reload the file
    vim.cmd("q!") -- Force quit
end, {})
