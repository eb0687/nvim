-- -- MKDNFLOW

-- -- SETUP [[[

-- require('mkdnflow').setup({
--     modules = {
--         -- NOTE: disable all keybindings
--         -- this is a temporary workaround to allow normal buffer navigation using TAB and SHIFT+TAB
--         -- if you want to re-enable bindings change maps to true
--         -- refer to this page for default configs -- https://github.com/jakewvincent/mkdnflow.nvim?utm_source=pocket_saves#%EF%B8%8F-configuration
--         maps = false,
--     },
-- })

-- -- ]]]
-- -- KEYMAPS [[[

-- local keymap = function(keys, func, desc)
--     if desc then
--         desc = 'MKDNFlow: ' .. desc
--     end

--     vim.keymap.set('n', keys, func, { desc = desc })
-- end

-- keymap("<leader>ml", ":MkdnCreateLink<CR>", 'Create a [M]arkdown [L]ink')

-- -- ]]]

-- -- TEST:
-- -- print("Hello from AFTER/MKDNFLOW")
