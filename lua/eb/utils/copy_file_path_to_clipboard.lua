-- https://github.com/dmmulroy/kickstart.nix/blob/main/config/nvim/lua/user/copy_file_path_to_clipboard.lua
vim.api.nvim_create_user_command("CopyFilePathToClipboard", function()
    vim.fn.setreg("+", vim.fn.expand("%:p"))
end, {})
