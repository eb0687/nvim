-- TREESITTER

-- protective call so nothing breaks if treesitter is missing
local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

-- SETUP [[[

configs.setup({
    -- NOTE: add more languages that you would like tree sitter syntax highlighting for
    ensure_installed = { "bash", "lua", "python", "vim", "yaml", "markdown", "help", "json", "html" },
    hightlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
        -- NOTE: list of languages that will be excluded from treesitter syntax highlighting
        disable = { " " }
    },
    -- NOTE: treesitter tries and makes indentation consistent with this option enabled
    indent = { enable = true, disable = { "yaml", "python" } },

    -- NOTE: using treesitter to improve visual selection within a code base.
    -- source: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            node_decremental = '<c-backspace>',
        },
    },
    text_objects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['aa'] = '@paramter.outer',
                ['ia'] = '@paramter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.outer',
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
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

-- ]]]

-- TEST:
-- print("Hello from AFTER/TREESITTER")
