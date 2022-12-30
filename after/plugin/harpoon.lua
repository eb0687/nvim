-- HARPOON

-- KEYMAPS [[[

-- Variables
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

local keymap = function(keys, func, desc)
    if desc then
        desc = 'Harpoon: ' .. desc
    end

    vim.keymap.set('n', keys, func, { desc = desc })
end

-- keymap("<leader>hm", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", '[H]arpoon [M]enu')
keymap("<leader>hm", ui.toggle_quick_menu, '[H]arpoon [M]enu')
keymap("<leader>ha", mark.add_file, '[H]arpoon [M]ark')
keymap("<leader>1", function() ui.nav_file(1) end, 'Add to harpoon key [1]')
keymap("<leader>2", function() ui.nav_file(2) end, 'Add to harpoon key [2]')
keymap("<leader>3", function() ui.nav_file(3) end, 'Add to harpoon key [3]')
keymap("<leader>4", function() ui.nav_file(4) end, 'Add to harpoon key [4]')

-- ]]]

-- TEST:
-- print("Hello from AFTER/HARPOON")
