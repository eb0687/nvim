--  _                       _
-- | |_   _  __ _ ___ _ __ (_)_ __
-- | | | | |/ _` / __| '_ \| | '_ \
-- | | |_| | (_| \__ \ | | | | |_) |
-- |_|\__,_|\__,_|___/_| |_|_| .__/
--                           |_|
-- https://github.com/L3MON4D3/LuaSnip

return {
    'L3MON4D3/LuaSnip',
    build = "make install_jsregexp",

    config = function()
        local ls = require("luasnip")
        -- local types = require("luasnip.util.types")

        local keymap = function(keys, func, desc)
            if desc then
                desc = 'LUASNIP: ' .. desc
            end

            vim.keymap.set({ 'i', "s" }, keys, func, { desc = desc })
        end

        local expand = function()
            if ls.expand_or_jumpable then
                ls.expand()
            end
        end

        local jump_next = function()
            if ls.jumpable(1) then
                ls.jump(1)
            end
        end

        local jump_previous = function()
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end

        local choice_next = function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end

        local choice_previous = function()
            if ls.choice_active() then
                ls.change_choice(-1)
            end
        end

        -- SETUP
        -- NOTE: path to my custom snippets
        require("luasnip.loaders.from_lua").load({
            paths = "~/.config/nvim/snippets"
        })

        -- NOTE: refer to this for more info: https://github.com/L3MON4D3/LuaSnip#add-snippets
        require("luasnip.loaders.from_vscode").lazy_load()

        ls.config.set_config({
            history = true,
            updateevents = "TextChanged,TextChangedI",
            enable_autosnippets = true,
            store_selection_keys = "<Tab>",
        })

        -- KEYMPS
        keymap("<a-s>", expand, "Expand Snippet")
        keymap("<a-1>", jump_previous, "Jump to previous section")
        keymap("<a-2>", jump_next, "Jump to next section")
        keymap("<a-3>", choice_previous, "Cycle through choices in choice node")
        keymap("<a-4>", choice_next, "Cycle through choices in choice node")

        -- TEST:
        -- print("Hello from lazy luasnip")
    end
}
