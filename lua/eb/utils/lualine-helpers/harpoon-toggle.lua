local M = {}

local harpoon = require("harpoon")
function M.toggle()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end

return M
