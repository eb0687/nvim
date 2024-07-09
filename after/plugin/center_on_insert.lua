-- Center document on insert
local function center_screen()
    vim.cmd("normal! zz")
end

-- Create an autocmd group to avoid duplication
local zz_group = vim.api.nvim_create_augroup("CenterOnInsertEnter", { clear = true })

-- Define the autocmd for InsertEnter event
vim.api.nvim_create_autocmd("InsertEnter", {
    group = zz_group,
    pattern = "*",
    callback = center_screen,
})
