-- TREESITTER

-- protective call so nothing breaks if treesitter is missing
local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

-- SETUP [[[

configs.setup({
    -- NOTE: add more languages that you would like tree sitter syntax highlighting for
    ensure_installed = { "bash", "lua", "python", "vim", "yaml", "markdown", "markdown_inline", "json", "html", "sql" },
    auto_install = false,
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

configs.setup {
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = { query = "@function.outer", desc = "Select around function" },
        ["if"] = { query = "@function.inner" , desc = "Select inner function" },
        ["ac"] = { query = "@class.outer", desc = "Select around class" },
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
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
        ['@function.outer'] = 'V', -- linewise
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
      include_surrounding_whitespace = true,
    },
  },
}

-- ]]]
-- KEYMAPS [[[

local keymap = function(mode, keys, func, desc)
    if desc then
        desc = 'DIAGNOSTIC: ' .. desc
    end
    vim.keymap.set(mode, keys, func, {
        noremap = true,
        silent = false,
        desc = desc
    })
end

keymap('n', '[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic message')
keymap('n', ']d', vim.diagnostic.goto_next, 'Go to next diagnostic message')
keymap('n', '<leader>dl', vim.diagnostic.setloclist, 'Open diagnostics list')

-- ]]]

-- TEST:
-- print("Hello from AFTER/TREESITTER")
