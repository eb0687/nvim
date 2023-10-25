--  _                      _ _   _
-- | |_ _ __ ___  ___  ___(_) |_| |_ ___ _ __
-- | __| '__/ _ \/ _ \/ __| | __| __/ _ \ '__|
-- | |_| | |  __/  __/\__ \ | |_| ||  __/ |
--  \__|_|  \___|\___||___/_|\__|\__\___|_|
-- https://github.com/nvim-treesitter/nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
-- https://youtu.be/CEMPq_r8UYQ
-- https://www.josean.com/posts/nvim-treesitter-and-textobjects

return {

    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects'
    },
    config = function()
        local treesitter = require('nvim-treesitter.configs')

        -- SETUP
        treesitter.setup({
            -- NOTE: add more languages that you would like tree sitter syntax highlighting for
            hightlight = {
                enable = true,
                additional_vim_regex_highlighting = { "markdown" },
                -- NOTE: list of languages that will be excluded from treesitter syntax highlighting
                disable = { " " }
            },
            -- NOTE: treesitter tries and makes indentation consistent with this option enabled
            indent = {
                enable = true,
                disable = { "yaml", "python" }
            },
            ensure_installed = {
                "bash",
                "lua",
                "python",
                "vim",
                "yaml",
                "markdown",
                "markdown_inline",
                "json",
                "html",
                "sql",
                "gitignore",
                "javascript",
            },
            auto_install = true,

            -- NOTE: using treesitter to improve visual selection within a code base.
            -- source: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<C-space>',
                    node_incremental = '<C-space>',
                    scope_incremental = false,
                    node_decremental = '<bs>',
                },
            },

            rainbow = {
                enable = true,
                -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                max_file_lines = nil, -- Do not enable for files with more than n lines, int
                -- colors = {}, -- table of hex strings
                -- termcolors = {} -- table of colour name strings
            }
        })

        treesitter.setup {
            textobjects = {
                select = {
                    enable = true,

                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,

                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["as"] = { query = "@assignment.outer", desc = "TS-goto: Select outer part of an assignment" },
                        ["is"] = { query = "@assignment.inner", desc = "TS-goto: Select inner part of an assignment" },
                        ["ls"] = { query = "@assignment.lhs", desc = "TS-goto: Select left hand side of an assignment" },
                        ["rs"] = { query = "@assignment.rhs", desc = "TS-goto: Select right hand side of an assignment" },

                        ["aa"] = { query = "@parmater.outer", desc =
                        "TS-goto: Select outer part of an argument/parameter" },
                        ["ia"] = { query = "@parmater.inner", desc =
                        "TS-goto: Select inner part of an argument/parameter" },

                        ["ai"] = { query = "@conditional.outer", desc = "TS-goto: Select outer part of a conditional" },
                        ["ii"] = { query = "@conditional.inner", desc = "TS-goto: Select inner part of a conditional" },

                        ["al"] = { query = "@loop.outer", desc = "TS-goto: Select outer part of a loop" },
                        ["il"] = { query = "@loop.inner", desc = "TS-goto: Select inner part of a loop" },

                        ["af"] = { query = "@function.outer", desc = "TS-goto: Select outer part of a function call" },
                        ["if"] = { query = "@function.inner", desc = "TS-goto: Select inner part of a function call" },

                        ["ac"] = { query = "@class.outer", desc = "TS-goto: Select outer part of a class" },
                        ["ic"] = { query = "@class.inner", desc = "TS-goto: Select inner part of a class" },
                    },
                    -- You can choose the select mode (default is charwise 'v')
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * method: eg 'v' or 'o'
                    -- and should return the mode ('v', 'V', or '<c-v>') or a table
                    -- mapping query_strings to modes.
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V',  -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
                    },
                    -- If you set this to `true` (default is `false`) then any textobject is
                    -- extended to include preceding or succeeding whitespace. Succeeding
                    -- whitespace has priority in order to act similarly to eg the built-in
                    -- `ap`.
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * selection_mode: eg 'v'
                    -- and should return true of false
                    -- include_surrounding_whitespace = true,
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]f"] = { query = '@call.outer', desc = 'TS-move: Next function call start' },
                        ["]m"] = { query = '@function.outer', desc = 'TS-move: Next method/function def start' },
                        ["]c"] = { query = '@class.outer', desc = 'TS-move: Next class start' },
                        ["]i"] = { query = '@conditional.outer', desc = 'TS-move: Next conditional start' },
                        ["]l"] = { query = '@loop.outer', desc = 'TS-move: Next loop start' },
                    },
                    goto_next_end = {
                        ["]F"] = { query = '@call.outer', desc = 'TS-move: Next function call end' },
                        ["]M"] = { query = '@function.outer', desc = 'TS-move: Next method/function def end' },
                        ["]C"] = { query = '@class.outer', desc = 'TS-move: Next class end' },
                        ["]I"] = { query = '@conditional.outer', desc = 'TS-move: Next conditional end' },
                        ["]L"] = { query = '@loop.outer', desc = 'TS-move: Next loop end' },
                    },
                    goto_previous_start = {
                        ["[f"] = { query = '@call.outer', desc = 'TS-move: Prev function call start' },
                        ["[m"] = { query = '@function.outer', desc = 'TS-move: Prev method/function def start' },
                        ["[c"] = { query = '@class.outer', desc = 'TS-move: Prev class start' },
                        ["[i"] = { query = '@conditional.outer', desc = 'TS-move: Prev conditional start' },
                        ["[l"] = { query = '@loop.outer', desc = 'TS-move: Prev loop start' },
                    },
                    goto_previous_end = {
                        ["[F"] = { query = '@call.outer', desc = 'TS-move: Prev function call end' },
                        ["[M"] = { query = '@function.outer', desc = 'TS-move: Prev method/function def end' },
                        ["[C"] = { query = '@class.outer', desc = 'TS-move: Prev class end' },
                        ["[I"] = { query = '@conditional.outer', desc = 'TS-move: Prev conditional end' },
                        ["[L"] = { query = '@loop.outer', desc = 'TS-move: Prev loop end' },
                    },
                },
            },
        }

        local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

        -- vim way: ; goes to the direction you were moving.
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

        -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
        -- NOTE: this does not seem to work, maybe interferance from flash.nvim plugin
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)

        --  KEYMAPS
        -- local keymap = function(mode, keys, func, desc)
        --     if desc then
        --         desc = 'DIAGNOSTIC: ' .. desc
        --     end
        --     vim.keymap.set(mode, keys, func, {
        --         noremap = true,
        --         silent = false,
        --         desc = desc
        --     })
        -- end

        -- keymap('n', '[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic message')
        -- keymap('n', ']d', vim.diagnostic.goto_next, 'Go to next diagnostic message')
        -- keymap('n', '<leader>dl', vim.diagnostic.setloclist, 'Open diagnostics list')


        -- TEST:
        -- print("Hello from lazy treesitter")
    end
}
