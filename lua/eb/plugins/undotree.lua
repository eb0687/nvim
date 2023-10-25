--                  _       _
--  _   _ _ __   __| | ___ | |_ _ __ ___  ___
-- | | | | '_ \ / _` |/ _ \| __| '__/ _ \/ _ \
-- | |_| | | | | (_| | (_) | |_| | |  __/  __/
--  \__,_|_| |_|\__,_|\___/ \__|_|  \___|\___|
-- https://github.com/mbbill/undotree

return {
    'mbbill/undotree',
    keys = {
        { "<F5>", ":UndotreeToggle<CR>", 'Undotree toggle' },
    },
    config = function()
        -- KEYMAP
        local keymap = function(keys, func, desc)
            if desc then
                desc = 'UNDOTREE: ' .. desc
            end

            vim.keymap.set('n', keys, func, { desc = desc })
        end

        keymap("<F5>", ":UndotreeToggle<CR>", 'Undotree toggle')
    end
}
