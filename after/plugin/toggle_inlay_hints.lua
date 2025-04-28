-- NOTE: Toggle inlay hints
local function toggle_inlay_hint()
    local is_enabled = vim.lsp.inlay_hint.is_enabled()
    vim.lsp.inlay_hint.enable(not is_enabled)
end

vim.api.nvim_create_user_command("ToggleInlayHints", function()
    toggle_inlay_hint()
end, { desc = "Toggle inlay hints" })
