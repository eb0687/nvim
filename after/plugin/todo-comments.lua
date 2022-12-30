-- TODO-COMMENTS

-- KEYMAPS [[[

-- Variables
local keymap = function(keys, func, desc)
    if desc then
        desc = 'TODO-COMMENTS: ' .. desc
    end

    vim.keymap.set('n', keys, func, { desc = desc })
end

keymap("]t", function()
    require("todo-comments").jump_next()
end,
    "Next todo comment")

keymap("[t", function()
    require("todo-comments").jump_prev()
end,
    "Previous todo comment")

-- ]]]

-- TEST:
-- print("Hello from AFTER/TODO-COMMENTS")
