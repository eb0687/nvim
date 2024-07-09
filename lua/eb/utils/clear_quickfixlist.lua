-- Clear the quickfix list
-- NOTE: SOURCE: https://gist.github.com/sideshowcoder/ba5faad45300737c66e9

local custom_helpers = require("eb.utils.custom_helpers")
local keymap_normal = custom_helpers.keymap_normal

-- Function to clear the quickfix list
local function clear_quickfix_list()
    vim.fn.setqflist({})
end

-- Create a custom command to call the function
vim.api.nvim_create_user_command("ClearQuickfixList", clear_quickfix_list, {})

-- Set up a normal mode key mapping to trigger the custom command
keymap_normal("<leader>cf", ":ClearQuickfixList<CR>", "CUSTOM", true, "Clear the quickfix list")
