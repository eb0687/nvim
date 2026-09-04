return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                pcall(vim.treesitter.start)

                local ensure_installed = {
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
                    "go",
                    "vimdoc",
                    "commonlisp",
                    "regex",
                    "tsx",
                    "css",
                }
                local already_installed = require("nvim-treesitter.config").get_installed()
                local parsers_to_install = vim.iter(ensure_installed)
                    :filter(function(parser)
                        return not vim.tbl_contains(already_installed, parser)
                    end)
                    :totable()
                require("nvim-treesitter").install(parsers_to_install)
            end,
        })
    end,
}
