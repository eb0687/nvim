-- Function to check if a binary exists in ~/.local/bin and execute it
local function ToggleAlacrittyOpacity()
    local home = os.getenv("HOME")
    local binary_path = home .. "/.local/bin/toggle-alacritty-opacity"

    if vim.fn.executable(binary_path) == 1 then
        vim.api.nvim_command("!" .. binary_path)
    else
        print(binary_path .. " not found")
    end
end

-- Create a Neovim user command to run the specified binary
vim.api.nvim_create_user_command(
    "ToggleAlacrittyOpacity",
    ToggleAlacrittyOpacity,
    { desc = "Toggle Alacritty Opacity" }
)
