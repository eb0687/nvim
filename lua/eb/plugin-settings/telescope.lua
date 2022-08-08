--  _       _
-- | |_ ___| | ___  ___  ___ ___  _ __   ___ 
-- | __/ _ \ |/ _ \/ __|/ __/ _ \| '_ \ / _ \
-- | ||  __/ |  __/\__ \ (_| (_) | |_) |  __/
--  \__\___|_|\___||___/\___\___/| .__/ \___|
--                               |_|

require('telescope').setup{
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = {"truncate"},
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
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    },
    pickers = {
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

-- [[[ Custom Functions

local MyFunc = {
}

-- search current buffer only
MyFunc.telescope_curr_buff = function()
    local opt = require('telescope.themes').get_dropdown({
        previewer=false,
    })
    require('telescope.builtin').current_buffer_fuzzy_find(opt)
end

-- search keymaps
MyFunc.telescope_keymap = function()
    local opt = require('telescope.themes').get_dropdown({
        previewer=false,
    })
    require('telescope.builtin').keymaps(opt)
end

-- search buffers
MyFunc.telescope_buffers = function()
    local opt = require('telescope.themes').get_dropdown({
        previewer = false,
    })
    require('telescope.builtin').buffers(opt)
end

-- search tmuxinator projects (currently not in use)
MyFunc.telescope_tmuxinator = function()
    local opt = require('telescope.themes').get_dropdown({
    })
    require('telescope').extensions.tmuxinator.projects(opt)
end

-- search history
MyFunc.telescope_search_history = function()
    local opt = require('telescope.themes').get_dropdown({
        previewer=false,
    })
    require('telescope.builtin').search_history(opt)
end

-- search history
MyFunc.telescope_command_history = function()
    local opt = require('telescope.themes').get_dropdown({
        previewer=false,
    })
    require('telescope.builtin').command_history(opt)
end

return MyFunc

-- ]]]
