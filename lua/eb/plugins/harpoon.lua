--   _
--  | |__   __ _ _ __ _ __   ___   ___  _ __
--  | '_ \ / _` | '__| '_ \ / _ \ / _ \| '_ \
--  | | | | (_| | |  | |_) | (_) | (_) | | | |
--  |_| |_|\__,_|_|  | .__/ \___/ \___/|_| |_|
--                   |_|
-- https://github.com/ThePrimeagen/harpoon

-- TODO:
-- refer to the github page for other integrations and usecases

return {
    'ThePrimeagen/harpoon',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        -- KEYMAPS
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        local keymap = function(keys, func, desc)
            if desc then
                desc = 'Harpoon: ' .. desc
            end

            vim.keymap.set('n', keys, func, { desc = desc })
        end

        keymap("<leader>hm", ui.toggle_quick_menu, '[H]arpoon [M]enu')
        keymap("<leader>ha", mark.add_file, '[H]arpoon [M]ark')
        keymap("<leader>1", function() ui.nav_file(1) end, 'Add to harpoon key [1]')
        keymap("<leader>2", function() ui.nav_file(2) end, 'Add to harpoon key [2]')
        keymap("<leader>3", function() ui.nav_file(3) end, 'Add to harpoon key [3]')
        keymap("<leader>4", function() ui.nav_file(4) end, 'Add to harpoon key [4]')

        -- TEST:
        -- print("Hello from lazy harpoon")
    end
}
