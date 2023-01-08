-- LUASNIP

-- VARIABLES [[[

local ls = require("luasnip")

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

-- ]]]
-- SETUP [[[

require("luasnip.loaders.from_lua").load({
    paths = "~/.config/nvim/snippets"
})

ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
    -- ext_opts = {
    --     [require("luasnip.util.types").choiceNode] = {
    --         active = {
    --             virt_text = { { "●", "GruvboxOrange " } },
    --         },
    --     },
    -- },
})

-- ]]]
-- KEYBINDS [[[

keymap("<a-s>", expand, "Expand Snippet")
keymap("<a-1>", jump_previous, "Jump to previous section")
keymap("<a-2>", jump_next, "Jump to next section")
keymap("<a-3>", choice_previous, "Cycle through choices in choice node")
keymap("<a-4>", choice_next, "Cycle through choices in choice node")

-- ]]]
