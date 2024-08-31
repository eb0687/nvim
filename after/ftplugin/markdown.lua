local keymap = function(mode, keys, func, desc)
    if desc then
        desc = "MARKDOWN DIAGNOSTIC: " .. desc
    end
    vim.keymap.set(mode, keys, func, {
        noremap = true,
        silent = false,
        desc = desc,
    })
end

-- jump to diagnostics
keymap("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
keymap("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic message")
