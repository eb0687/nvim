-- https://github.com/dmmulroy/kickstart.nix/blob/main/config/nvim/lua/user/vertical_help.lua
-- BUG: the below aucommand works, however when paired with maximizez.nvim it closes the help window
-- vim.api.nvim_create_autocmd("FileType", {
--     group = vim.api.nvim_create_augroup("vertical_help", { clear = true }),
--     pattern = "help",
--     callback = function()
--         vim.bo.bufhidden = "unload"
--         vim.cmd.wincmd("L")
--         vim.cmd.wincmd("=")
--     end,
-- })

-- Create the autocmd for setting help windows to vertical split
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("vertical_help", { clear = true }),
    pattern = "help",
    callback = function()
        vim.bo.bufhidden = "unload"
        local is_maximized = vim.fn.exists(":Maximize") == 2 and vim.g.maximized or false
        if not is_maximized then
            vim.cmd.wincmd("L") -- Move the help window to a vertical split
            vim.cmd.wincmd("=") -- Equalize window sizes
        end
    end,
})
