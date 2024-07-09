--            _       _        __ _
--  _ __ ___ | | ____| |_ __  / _| | _____      __
-- | '_ ` _ \| |/ / _` | '_ \| |_| |/ _ \ \ /\ / /
-- | | | | | |   < (_| | | | |  _| | (_) \ V  V /
-- |_| |_| |_|_|\_\__,_|_| |_|_| |_|\___/ \_/\_/
-- https://github.com/folke/lazy.nvim

return {

    "jakewvincent/mkdnflow.nvim",
    ft = "markdown",

    config = function()
        local mkdnflow = require("mkdnflow")
        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_normal = custom_helpers.keymap_normal

        -- SETUP
        mkdnflow.setup({
            modules = {
                -- NOTE: disable all keybindings
                -- this is a temporary workaround to allow normal buffer navigation using TAB and SHIFT+TAB
                -- if you want to re-enable bindings change maps to true
                -- refer to this page for default configs -- https://github.com/jakewvincent/mkdnflow.nvim?utm_source=pocket_saves#%EF%B8%8F-configuration
                maps = false,
            },
        })

        -- KEYMAPS
        -- local keymap = function(keys, func, desc)
        --     if desc then
        --         desc = "MKDNFlow: " .. desc
        --     end

        --     vim.keymap.set("n", keys, func, { desc = desc })
        -- end

        keymap_normal("<leader>ml", ":MkdnCreateLink<CR>", "MKDNFlow", true, "Create a [M]arkdown [L]ink")

        -- TEST:
        -- print("Hello from lazy mkdnflow")
    end,
}
