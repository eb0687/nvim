-- MINI MISC

local M = {}

function M.setup()
    require("mini.misc").setup({})
    require("mini.misc").setup_restore_cursor()

    local custom_helpers = require("eb.utils.custom_helpers")
    local keymap_silent = custom_helpers.keymap_silent

    keymap_silent("n", "<leader>=", function()
        require("mini.misc").zoom()
    end, "MINI: Zoom in/out buffer")
end

return M
