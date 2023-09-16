-- -- tabs-vs-spaces (https://github.com/tenxsoydev/tabs-vs-spaces.nvim)

-- -- protective call so nothing breaks if nvim-tree is missing
-- local status_ok, tabsvspace = pcall(require, "tabs-vs-spaces")
-- if not status_ok then
--     return
-- end

-- -- SETUP [[[

-- tabsvspace.setup{
--     -- Preferred indentation. Possible values: "auto"|"tabs"|"spaces".
--     -- "auto" detects the dominant indentation style in a buffer and highlights deviations.
--     indentation = "auto",
--     -- Use a string like "DiagnosticUnderlineError" to link the `TabsVsSpace` highlight to another highlight.
--     -- Or a table valid for `nvim_set_hl` - e.g. { fg = "MediumSlateBlue", undercurl = true }.
--     -- NOTE: Disabled because too much visual clutter
--     -- highlight = "DiagnosticUnderlineHint",
--     highlight = "",
--     -- Priority of highight matches.
--     priority = 20,
--     ignore = {
--     filetypes = {},
--     -- Works for normal buffers by default.
--     buftypes = {
--       "acwrite",
--       "help",
--       "nofile",
--       "nowrite",
--       "quickfix",
--       "terminal",
--       "prompt",
--     },
--     },
--     standartize_on_save = false,
--     -- Enable or disable user commands see Readme.md/#Commands for more info.
--     user_commands = true,
-- }

-- -- ]]]
-- -- KEYMAP [[[

-- -- Variables
-- local keymap = function(keys, func, desc)
--     if desc then
--         desc = 'Tabs vs Spaces: ' .. desc
--     end

--     vim.keymap.set('v', keys, func, { desc = desc })
-- end

-- -- Bindings
-- keymap('<leader>ct', ':TabsVsSpacesConvert', 'Convert tabs to spaces OR vice versa')


-- -- ]]]

-- -- TEST:
-- -- print("Hello from AFTER/TABS-VS-SPACES")
