--  _       _
-- | |_ ___| | ___  ___  ___ ___  _ __   ___
-- | __/ _ \ |/ _ \/ __|/ __/ _ \| '_ \ / _ \
-- | ||  __/ |  __/\__ \ (_| (_) | |_) |  __/
--  \__\___|_|\___||___/\___\___/| .__/ \___|
--                               |_|

-- TODO: create a pcall for this plugin

-- SETUP [[[
require('telescope').setup {
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.50,
                results_width = 0.50,
            },
            center = {
                width = 1.0,
                height = 1.0,
            },
        },
        winblend = 0,
        scroll_strategy = "cycle",
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        file_ignore_patterns = { "^.git/" },
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    },
    pickers = {
        find_files = {
            hidden = true
        }
    },
    extensions = {
        tmuxinator = {
            select_action = 'switch',
            stop_action = 'stop',
            disable_icons = false,
        },
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- ]]]
-- KEYMAPS [[

-- Variables
local keymap = function(keys, func, desc)
    if desc then
        desc = 'TELESCOPE: ' .. desc
    end

    vim.keymap.set('n', keys, func, { desc = desc })
end

local custom_theme = require('telescope.themes').get_dropdown({
    previewer = false,
})

local telescope_builtin = require('telescope.builtin')

-- Mappings
keymap("<leader>fo", telescope_builtin.oldfiles, 'Find recently Opened files')
keymap("<leader>fk", telescope_builtin.keymaps, 'Find Keymaps')
keymap("<leader>fh", telescope_builtin.help_tags, 'Find in Help tags')
keymap("<leader>fp", telescope_builtin.man_pages, 'Find in man Pages')
keymap("<leader>fm", telescope_builtin.marks, 'Find in vim marks')
keymap("<leader>ff", telescope_builtin.find_files, 'Find Files in local folder only recursively')
keymap("<leader>fg", telescope_builtin.git_files, 'Find files in Git repository')

keymap("<leader>fs", function()
    telescope_builtin.grep_string({
        search = vim.fn.input('Grep for > ')
    })
end, 'Find using Grep')

keymap("<leader>fn", function()
    telescope_builtin.find_files({
        prompt_title = '[ VIMRC ]',
        cwd = '~/.config/nvim/'
    })
end, 'Find in Nvim configs')

keymap("<leader>fF", function()
    telescope_builtin.find_files({
        prompt_title = '[ Search HOME ]',
        cwd = '~/'
    })
end, 'Find Files in home directory')

keymap("<leader>fw", function()
    telescope_builtin.grep_string({
        search = vim.fn.expand('<cword>'),
        grep_open_files = true
    })
end, 'Find Word under cursor')

keymap("<leader>fb", function()
    telescope_builtin.buffers(custom_theme)
end, 'Find in existing Buffers')

keymap("<leader>fsh", function()
    telescope_builtin.search_history(custom_theme)
end, 'Find Search History')

keymap('<leader>fcb', function()
    telescope_builtin.current_buffer_fuzzy_find(custom_theme)
end, 'Find Current Buffer')

keymap("<leader>fch", function()
    telescope_builtin.command_history(custom_theme)
end, 'Find Command History')

--]]

-- TEST:
-- print('Hello from AFTER/TELESCOPE')
