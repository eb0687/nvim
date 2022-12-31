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

-- ]]]
-- KEYMAPS [[[

-- Variables
local keymap = function(keys, func, desc)
    if desc then
        desc = 'Telescope: ' .. desc
    end

    vim.keymap.set('n', keys, func, { desc = desc })
end

local custom_theme = require('telescope.themes').get_dropdown({
    previewer = false,
})

-- Mappings
keymap("<leader>fo", require('telescope.builtin').oldfiles, '[F]ind recently [O]pened files')
keymap("<leader>fk", require('telescope.builtin').keymaps, '[F]ind [K]eymaps')
keymap("<leader>fh", require('telescope.builtin').help_tags, '[F]ind in [H]elp tags')
keymap("<leader>fp", require('telescope.builtin').man_pages, '[F]ind in man [P]ages')
keymap("<leader>fm", require('telescope.builtin').marks, '[F]ind in vim marks')
keymap("<leader>ff", require('telescope.builtin').find_files, '[F]ind [F]iles in local folder only recursively')
keymap("<leader>fg", require('telescope.builtin').git_files, '[F]ind files in [G]it repository')
keymap("<leader>fg", require('telescope.builtin').git_files, '[F]ind files in [G]it repository')

keymap("<leader>fs", function()
    require('telescope.builtin').grep_string({
        search = vim.fn.input('Grep for > ')
    })
end, '[F]ind using [G]rep')

keymap("<leader>fn", function()
    require('telescope.builtin').find_files({
        prompt_title = '[ VIMRC ]',
        cwd = '~/.config/nvim/'
    })
end, '[F]ind in [N]vim configs')

keymap("<leader>fF", function()
    require('telescope.builtin').find_files({
        prompt_title = '[ Search HOME ]',
        cwd = '~/'
    })
end, '[F]ind [F]iles in home directory')

keymap("<leader>fw", function()
    require('telescope.builtin').grep_string({
        search = vim.fn.expand('<cword>')
    })
end, '[F]ind [W]ord under cursor')

keymap("<leader>fb", function()
    require('telescope.builtin').buffers(custom_theme)
end, '[F]ind in existing [B]uffers')

keymap("<leader>fsh", function()
    require('telescope.builtin').search_history(custom_theme)
end, '[F]ind [S]earch [H]istory')

keymap('<leader>fcb', function()
    require('telescope.builtin').current_buffer_fuzzy_find(custom_theme)
end, '[F]ind [C]urrent [B]uffer')

keymap("<leader>fch", function()
    require('telescope.builtin').command_history(custom_theme)
end, '[fch] [F]ind [C]ommand [H]istory')

-- ]]]

-- TEST:
-- print('Hello from AFTER/TELESCOPE')
