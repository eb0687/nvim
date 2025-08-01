--                  _       _
--  _   _ _ __   __| | ___ | |_ _ __ ___  ___
-- | | | | '_ \ / _` |/ _ \| __| '__/ _ \/ _ \
-- | |_| | | | | (_| | (_) | |_| | |  __/  __/
--  \__,_|_| |_|\__,_|\___/ \__|_|  \___|\___|
-- https://github.com/mbbill/undotree

-- NOTE: have not used this at all, disabling for now until there is a need to use it
-- TODO: need to enable and start using this again soon

return {
    "mbbill/undotree",
    enabled = false,
    keys = {
        { "<F5>", ":UndotreeToggle<CR>", "Undotree toggle" },
    },
    config = function()
        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_normal = custom_helpers.keymap_normal

        keymap_normal("<F5>", ":UndotreeToggle<CR>", "UNDOTREE", true, "Undotree toggle")
    end,
}
