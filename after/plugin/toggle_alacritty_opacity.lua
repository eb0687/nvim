local user_command = vim.api.nvim_create_user_command
local custom_helpers = require("eb.utils.custom_helpers")
local keymap_normal = custom_helpers.keymap_normal
local function ToggleAlacrittyOpacity()
    local home = os.getenv("HOME")
    local binary_path = home .. "/.local/bin/toggle-alacritty-opacity"

    if vim.fn.executable(binary_path) == 1 then
        vim.api.nvim_command("!" .. binary_path)
    else
        print(binary_path .. " not found")
    end
end

local toggle_zen = false
local function ToggleZen()
    local home = os.getenv("HOME")
    local binary_path = home .. "/.local/bin/toggle-alacritty-opacity"

    if toggle_zen then
        if vim.fn.executable(binary_path) == 1 then
            vim.api.nvim_command("!" .. binary_path)
            vim.api.nvim_command(":" .. "NoNeckPain")
            vim.o.laststatus = 3
        else
            print(binary_path .. " not found")
        end
    else
        vim.api.nvim_command("!" .. binary_path)
        vim.api.nvim_command(":" .. "NoNeckPain")
        vim.o.laststatus = 0
    end
    toggle_zen = not toggle_zen
end

user_command("ToggleAlacrittyOpacity", ToggleAlacrittyOpacity, { desc = "Toggle Alacritty Opacity" })
user_command("ToggleZen", ToggleZen, { desc = "Toggle Custom Zen Mode" })

keymap_normal("<leader>ta", ":ToggleAlacrittyOpacity<CR>", "CUSTOM", true, "Runs the toggle-alacritty-opacity binary")
keymap_normal("<leader>tz", ":ToggleZen<CR>", "CUSTOM", true, "Toggle custom zen mode")
