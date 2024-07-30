local user_command = vim.api.nvim_create_user_command

user_command("DBUItab", "tabnew | DBUI", {})
