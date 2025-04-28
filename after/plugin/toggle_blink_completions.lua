-- NOTE: toggle blink completions

vim.g.blink_cmp = true

local function toggle_autocomplete()
    vim.g.blink_cmp = not vim.g.blink_cmp
    local status

    if vim.g.blink_cmp then
        status = "ENABLED"
    else
        status = "DISABLED"
    end

    print("Autocomplete", status)
end

vim.api.nvim_create_user_command("ToggleBlinkCompletions", toggle_autocomplete, {})
