-- CODE RUNNER

-- SETUP [[[

-- NOTE: refer to this link for more configuration options: https://github.com/CRAG666/code_runner.nvim#default-values
require("code_runner").setup({
    -- choose default mode (valid term, tab, float, toggle, buf)
    mode = 'term',
    -- Focus on runner window(only works on toggle, term and tab mode)
    focus = true,
    -- startinsert (see ':h inserting-ex')
    startinsert = true,
})

-- ]]]
-- KEYMAPS [[[

-- Variables
local keymap = function(keys, func, desc)
    if desc then
        desc = 'CODE_RUNNER: ' .. desc
    end

    vim.keymap.set('n', keys, func, { desc = desc })
end

keymap("<leader>rr", ":RunCode<CR>", "Execute code")

-- ]]]
