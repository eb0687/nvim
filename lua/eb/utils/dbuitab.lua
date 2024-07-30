local user_command = vim.api.nvim_create_user_command
local custom_helpers = require("eb.utils.custom_helpers")
local keymap_normal = custom_helpers.keymap_normal

user_command("DBUItab", "tabnew | DBUI", {})

keymap_normal("<leader>dbt", ":DBUItab<CR>", "CUSTOM", true, "Open DBUI in a new tab")
