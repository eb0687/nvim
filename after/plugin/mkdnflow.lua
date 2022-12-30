-- MKDNFLOW

-- KEYMAPS [[[

local keymap = function(keys, func, desc)
    if desc then
        desc = 'MKDNFlow: ' .. desc
    end

    vim.keymap.set('n', keys, func, { desc = desc })
end

keymap("<leader>ml", ":MkdnCreateLink<CR>", 'Create a [M]arkdown [L]ink')

-- ]]]
--
-- TEST:
-- print("Hello from AFTER/MKDNFLOW")
