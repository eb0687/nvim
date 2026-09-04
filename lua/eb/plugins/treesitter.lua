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

                -- NOTE: tree-sitter incremental selection from Nasser
                vim.keymap.set("n", "<C-space>", function()
                    -- press v to enter visual mode
                    vim.cmd("normal! v")
                    if vim.treesitter.get_parser(nil, nil, { error = false }) then
                        require("vim.treesitter._select").select_parent(vim.v.count1)
                    else
                        vim.lsp.buf.selection_range(vim.v.count1)
                    end
                end, { desc = "Select parent (outer) node" })

                vim.keymap.set({ "x", "o" }, "<C-space>", function()
                    if vim.treesitter.get_parser(nil, nil, { error = false }) then
                        require("vim.treesitter._select").select_parent(vim.v.count1)
                    else
                        vim.lsp.buf.selection_range(vim.v.count1)
                    end
                end, { desc = "Select parent (outer) node" })

                vim.keymap.set({ "x", "o" }, "in", function()
                    if vim.treesitter.get_parser(nil, nil, { error = false }) then
                        require("vim.treesitter._select").select_child(vim.v.count1)
                    else
                        vim.lsp.buf.selection_range(-vim.v.count1)
                    end
                end, { desc = "Select child (inner) node" })
            end,
        })
    end,
}
