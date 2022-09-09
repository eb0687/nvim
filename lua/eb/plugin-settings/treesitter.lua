-- protective call so nothing breaks if treesitter is missing
local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

-- setup
configs.setup({
    -- add more languages that you would like tree sitter syntax highlighting for
    ensure_installed = { "bash", "lua", "python", "vim", "yaml", "markdown" },
    hightlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
        -- list of languages that will be excluded from treesitter syntax highlighting
        disable = { " " }
    },
    -- treesitter tries and makes indentation consistent with this option enabled
    indent = { enable = true, disable = {"yaml", "python"} },
    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    }
})
