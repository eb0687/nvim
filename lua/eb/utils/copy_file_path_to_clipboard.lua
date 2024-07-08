-- https://github.com/dmmulroy/kickstart.nix/blob/dcb116a6bceb73285636cfe57a93b3a636b4bf6f/config/nvim/lua/user/copy_file_path_to_clipboard.lua
vim.api.nvim_create_user_command("CopyFilePathToClipboard", function()
    vim.fn.setreg("+", vim.fn.expand("%:p"))
end, {})
