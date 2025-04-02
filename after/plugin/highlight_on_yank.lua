-- https://github.com/dmmulroy/kickstart.nix/blob/main/config/nvim/lua/user/highlight_yank.lua
-- Hihgliht yanked auto command
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    pattern = "*",
    desc = "Highlight selection on yank",
    callback = function()
        vim.b.minicursorword_disable = true
        vim.highlight.on_yank({ timeout = 200, visual = true, higroup = "YankHi" })
        vim.defer_fn(function()
            vim.b.minicursorword_disable = nil
            -- Trigger 'mini.cursorword' re-render after yank highlight is hidden
            vim.cmd("doautocmd CursorMoved")
        end, 220)
        -- vim.highlight.on_yank({ timeout = 200, visual = true, higroup = "YankHi" })
    end,
})
