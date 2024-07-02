--  _                            __ _
-- | |___ _ __   ___ ___  _ __  / _(_) __ _
-- | / __| '_ \ / __/ _ \| '_ \| |_| |/ _` |
-- | \__ \ |_) | (_| (_) | | | |  _| | (_| |
-- |_|___/ .__/ \___\___/|_| |_|_| |_|\__, |
--       |_|                          |___/
-- https://github.com/neovim/nvim-lspconfig

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local util = require("lspconfig/util")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        -- Capabilities
        -- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- NOTE:
        -- Capabilities required for the visualstudio lsps (css, html, etc)
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssls
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities.textDocument.completion.completionItem.preselectSupport = true
        capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
        capabilities.textDocument.completion.completionItem.resolveSupport = {
            properties = {
                'documentation',
                'detail',
                'additionalTextEdits'
            },
        }

        -- NOTE: Use an on_attach function to only map the following keys after the language server attaches to the current buffer
        local on_attach = function(client, bufnr)
            local keymap = function(keys, func, desc)
                if desc then
                    desc = "LSP: " .. desc
                end

                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
            end

            -- KEYMAPS
            keymap("[d", ":Lspsaga diagnostic_jump_prev<CR>", "Go to previous diagnostic message")
            keymap("]d", ":Lspsaga diagnostic_jump_next<CR>", "Go to next diagnostic message")
            keymap("gp", ":Lspsaga peek_definition<CR>", "Go to next diagnostic message")
            keymap("rn", ":Lspsaga rename<CR>", "Rename")
            keymap("K", ":Lspsaga hover_doc<CR>", "Hover documentation")
            keymap("<leader>ca", ":Lspsaga code_action<CR>", "Code action")
            keymap("fi", ":Lspsaga finder<CR>", "Finder saga window")
            keymap("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
            keymap("gD", ":Lspsaga goto_definition<CR>", "Goto Definition")
            keymap("df", ":Lspsaga show_cursor_diagnostics ++normal<CR>", "Open Diagnostic Float")

            keymap("gI", vim.lsp.buf.implementation, "Goto Implementation")
            -- keymap("df", vim.diagnostic.open_float, "Open Diagnostic Float")
            -- keymap('rn', vim.lsp.buf.rename, 'ReName')
            -- keymap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
            -- keymap('gr', require('telescope.builtin').lsp_references, 'Goto References')
            -- keymap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
            -- keymap('<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', 'Format code')

            -- NOTE: `:help K` for why this keymap
            keymap("<leader>D", vim.lsp.buf.signature_help, "Signature Documentation")

            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
                vim.lsp.buf.format()
            end, { desc = "Format current buffer with LSP" })

            -- Disable tsserver autoformat
            if client.name == "tsserver" then
                client.server_capabilities.documentFormattingProvider = false
            end
            -- client.server_capabilities.document_formatting = false
            -- client.server_capabilities.document_range_formatting = false

            -- Diagnostic Signs
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            -- NOTE: hover config, using noice for now
            -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            --     vim.lsp.handlers.hover, {
            --         border = "none",
            --     }
            -- )
        end

        -- LANGUAGE SERVER CONFIGURATION

        -- vim
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#vimls
        -- https://github.com/iamcco/vim-language-server
        lspconfig.vimls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }

        -- ansible
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ansiblels
        -- https://github.com/ansible/ansible-language-server
        -- TODO: ansible lsp is not working, need to fix
        lspconfig.ansiblels.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { "yaml", "yml", "ansible" },
            single_file_support = false,
            root_dir = lspconfig.util.root_pattern("roles", "playbooks", "ansible"),

        }

        -- lua
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
        -- https://github.com/luals/lua-language-server
        lspconfig.lua_ls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = { -- custom settings for lua
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    telemetry = {
                        enable = false,
                    },
                    -- make the language server recognize "vim" global
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        }

        -- pyright
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright
        -- https://github.com/microsoft/pyright
        lspconfig.pyright.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                pyright = {
                    disableOrganizeImports = false,
                    analysis = {
                        useLibraryCodeForTypes = true,
                        autoSearchPaths = true,
                        diagnosticMode = "workspace",
                        autoImportCompletions = true,
                    },
                },
            },
        }

        -- javascript, typescript
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
        -- https://github.com/typescript-language-server/typescript-language-server
        lspconfig.tsserver.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = {
                "javascript",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx"
            },
            root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
        }

        -- bash
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
        -- https://github.com/bash-lsp/bash-language-server
        -- NOTE: bashls integrates shellcheck by default

        lspconfig.bashls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { "sh" },
        }

        -- html, typescriptreact, javascriptreact, css, sass, scss, less, svelte, vue
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#emmet_ls
        -- https://github.com/aca/emmet-ls
        lspconfig.emmet_ls.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = {
                "html",
                "typescriptreact",
                "javascriptreact",
                "javascript",
                "css",
                "sass",
                "scss",
                "less",
                "svelte",
                "vue",
            },
        }

        -- json
        lspconfig.jsonls.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "json", "jsonc" },
        }

        -- tailwindcss
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tailwindcss
        -- https://github.com/tailwindlabs/tailwindcss-intellisense
        -- NOTE: this requires tailwind to be setup properly in the poject directory
        lspconfig.tailwindcss.setup {
            capabilities = capabilities,
            on_attach = on_attach,

        }

        -- sql
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sqlls
        -- https://github.com/joe-re/sql-language-server
        lspconfig.sqlls.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "sql-language-server", "up", "--method", "stdio" },
            filetypes = { "sql", "mysql" },
            root_dir = function()
                return vim.loop.cwd()
            end,
        }

        -- golang
        -- https://github.com/golang/tools/blob/master/gopls/doc/vim.md
        lspconfig.gopls.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            root_dir = util.root_pattern("go.work", "go.mod", ".git"),
            settings = {
                gopls = {
                    completeUnimported = true,
                    usePlaceholders = true,
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                    gofumpt = true,
                },
            },
        }

        -- TEST:
        -- print("Hello from lazy lspconfig")
    end,
}
