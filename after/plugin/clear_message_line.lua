vim.api.nvim_create_user_command("ClearMessages", function()
    print("")
end, { desc = "Clear messge line" })
