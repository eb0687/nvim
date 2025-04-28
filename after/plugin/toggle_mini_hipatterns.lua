-- NOTE: Toggle MiniHiPattern usercommand
vim.api.nvim_create_user_command("ToggleMiniHipatterns", function()
    MiniHipatterns.toggle()
end, { desc = "Toggle MiniHipatterns" })
