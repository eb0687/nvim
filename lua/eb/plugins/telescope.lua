--  _       _
-- | |_ ___| | ___  ___  ___ ___  _ __   ___
-- | __/ _ \ |/ _ \/ __|/ __/ _ \| '_ \ / _ \
-- | ||  __/ |  __/\__ \ (_| (_) | |_) |  __/
--  \__\___|_|\___||___/\___\___/| .__/ \___|
--                               |_|
-- https://github.com/nvim-telescope/telescope.nvim

return {
    'nvim-telescope/telescope.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = 'Telescope',
    branch = '0.1.x',
    dependencies = {
        {
            'nvim-tree/nvim-web-devicons',
            lazy = true,
        },
        'nvim-lua/plenary.nvim',
        { 'nvim-tree/nvim-web-devicons', lazy = true },
        'nvim-telescope/telescope-github.nvim',
        'ThePrimeagen/harpoon',
        'natecraddock/telescope-zf-native.nvim',
        {
            'piersolenski/telescope-import.nvim',
            ft = { 'python', 'javascript', 'lua' },
        },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = "make",
        },
    },

    config = function()
        local telescope = require("telescope")

        -- SETUP
        telescope.setup({
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
                import = {
                    -- Add imports to the top of the file keeping the cursor in place
                    insert_at_top = true,
                },
            },

            telescope.load_extension('fzf'),
            telescope.load_extension('notify'),
            telescope.load_extension('harpoon'),
            telescope.load_extension('zf-native'),
            telescope.load_extension('import'),
            telescope.load_extension('refactoring'),
        })

        -- KEYMAPS
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

        -- keybinds
        keymap("<leader>ff", telescope_builtin.find_files, 'Find Files in local folder only recursively')
        keymap("<leader>fo", telescope_builtin.oldfiles, 'Find recently Opened files')
        keymap("<leader>fk", telescope_builtin.keymaps, 'Find Keymaps')
        keymap("<leader>fh", telescope_builtin.help_tags, 'Find in Help tags')
        keymap("<leader>fp", telescope_builtin.man_pages, 'Find in man Pages')
        keymap("<leader>fm", telescope_builtin.marks, 'Find in vim marks')
        keymap("<leader>fg", telescope_builtin.git_files, 'Find files in Git repository')
        keymap("gr", telescope_builtin.lsp_references, 'Find references [LSP]')
        keymap("gd", telescope_builtin.lsp_definitions, 'Find definitions [LSP]')
        keymap("gD", telescope_builtin.lsp_type_definitions, 'Find type definitions [LSP]')
        keymap("<leader>ds", telescope_builtin.lsp_document_symbols, 'Find document symbols [LSP]')
        keymap("<leader>co", telescope_builtin.quickfix, 'View all items in the quickfix list')
        -- BUG: this does not reload modules but does show the notification
        keymap("<leader>fr", "<cmd>:lua require('eb.utils.telescope_reload').reload()<CR>",
            'Reload nvim plugin using telescope')

        keymap("<leader>fs", function()
            telescope_builtin.grep_string({
                search = vim.fn.input('Grep for > ')
            })
        end, 'Find using Grep')

        keymap("<leader>fn", function()
            telescope_builtin.find_files({
                prompt_title = '[ VIMRC ]',
                file_ignore_patterns = { "^.git/" },
                cwd = '~/.config/nvim/'
            })
        end, 'Find in Nvim configs')

        keymap("<leader>fF", function()
            telescope_builtin.find_files({
                prompt_title = '[ Search HOME ]',
                file_ignore_patterns = { "^.git/" },
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

        vim.keymap.set(
            { "n", "x" },
            "<leader>re",
            function() require('telescope').extensions.refactoring.refactors() end
        )

        -- TEST:
        -- print("Hello from lazy telescope")
    end
}
