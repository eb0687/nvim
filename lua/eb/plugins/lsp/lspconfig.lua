--  _                            __ _
-- | |___ _ __   ___ ___  _ __  / _(_) __ _
-- | / __| '_ \ / __/ _ \| '_ \| |_| |/ _` |
-- | \__ \ |_) | (_| (_) | | | |  _| | (_| |
-- |_|___/ .__/ \___\___/|_| |_|_| |_|\__, |
--       |_|                          |___/
-- https://github.com/neovim/nvim-lspconfig

-- TODO: install trouble.nvim using this guide: https://youtu.be/6pAG3BHurdM?t=4307https://youtu.be/6pAG3BHurdM?t=4307

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        -- "hrsh7th/cmp-nvim-lsp",
        { "saghen/blink.cmp" },
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local util = require("lspconfig/util")

        local capabilities = {
            textDocument = {
                foldingRange = {
                    dynamicRegistration = false,
                    lineFoldingOnly = true,
                },
            },
        }

        -- NOTE: disables the default keymap for nepvim native lsp
        vim.keymap.del("n", "grr")
        vim.keymap.del("n", "gra")
        vim.keymap.del("n", "gri")
        vim.keymap.del("n", "grn")

        capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

        -- NOTE: old capabilities for cmp
        -- Capabilities
        -- local cmp_nvim_lsp = require("cmp_nvim_lsp")
        -- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
        -- local capabilities = cmp_nvim_lsp.default_capabilities()

        -- NOTE:
        -- Capabilities required for the visualstudio lsps (css, html, etc)
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssls
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        -- capabilities.textDocument.completion.completionItem.preselectSupport = true
        -- capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
        -- capabilities.textDocument.completion.completionItem.resolveSupport = {
        --     properties = {
        --         "documentation",
        --         "detail",
        --         "additionalTextEdits",
        --     },
        -- }

        -- NOTE: to disable new keymaps for lsp
        -- vim.keymap.set("n", "grr", "<Nop>", { noremap = true, silent = true })
        -- vim.keymap.set("n", "grn", "<Nop>", { noremap = true, silent = true })
        -- vim.keymap.set("n", "gri", "<Nop>", { noremap = true, silent = true })
        -- vim.keymap.set("n", "gO", "<Nop>", { noremap = true, silent = true })
        -- vim.keymap.set("n", "gra", "<Nop>", { noremap = true, silent = true })

        -- NOTE: Use an on_attach function to only map the following keys after the language server attaches to the current buffer
        local on_attach = function(client, bufnr)
            local keymap = function(keys, func, desc)
                if desc then
                    desc = "LSP: " .. desc
                end

                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc, silent = true })
            end

            -- KEYMAPS
            keymap("[d", ":Lspsaga diagnostic_jump_prev<CR>", "Go to previous diagnostic message")
            keymap("]d", ":Lspsaga diagnostic_jump_next<CR>", "Go to next diagnostic message")
            keymap("gp", ":Lspsaga peek_definition<CR>", "Go to next diagnostic message")
            keymap("rn", function()
                vim.lsp.buf.rename()
            end, "Rename")
            keymap("K", function()
                vim.lsp.buf.hover({
                    border = { "", "─", "╮", "│", "╯", "─", "╰", "│" },
                })
            end, "Hover documentation")
            keymap("<leader>ca", function()
                vim.lsp.buf.code_action()
            end, "Code action")
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "code action" })
            keymap("fi", ":Lspsaga finder<CR>", "Finder saga window")
            keymap("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
            keymap("gr", require("telescope.builtin").lsp_references, "Goto References")
            keymap("gD", ":Lspsaga goto_definition<CR>", "Goto Definition")
            keymap("df", ":Lspsaga show_cursor_diagnostics ++normal<CR>", "Open Diagnostic Float")

            keymap("gI", vim.lsp.buf.implementation, "Goto Implementation")
            keymap("<space>fr", '<cmd>lua require("conform").format()<CR>', "Format code")

            -- NOTE: `:help K` for why this keymap
            keymap("<leader>D", vim.lsp.buf.signature_help, "Signature Documentation")

            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
                require("conform").format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 1000,
                })
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
        lspconfig.vimls.setup({
            on_attach = on_attach,
            -- capabilities = capabilities,
        })

        -- ansible
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ansiblels
        -- https://github.com/ansible/ansible-language-server
        -- TODO: ansible lsp is not working, need to fix
        lspconfig.ansiblels.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { "yaml", "yml", "ansible" },
            single_file_support = false,
            root_dir = lspconfig.util.root_pattern("roles", "playbooks", "ansible"),
        })

        -- lua
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
        -- https://github.com/luals/lua-language-server
        lspconfig.lua_ls.setup({
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
                    format = {
                        enable = false,
                    },
                    hint = {
                        enable = true,
                    },
                    workspace = {
                        -- library = {
                        --     [vim.fn.expand("$XDG_DATA_HOME/nvim/lazy")] = true,
                        --     [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        --     [vim.fn.stdpath("config") .. "/lua"] = true,
                        -- },
                    },
                    completion = {
                        callSnippet = "Replace",
                    },
                },
            },
        })

        -- pyright
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright
        -- https://github.com/microsoft/pyright
        lspconfig.pyright.setup({
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
        })

        -- javascript, typescript
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
        -- https://github.com/typescript-language-server/typescript-language-server
        local inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
        }

        lspconfig.ts_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = {
                "javascript",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx",
            },
            root_dir = lspconfig.util.root_pattern("jsconfig.json", "package.json", "tsconfig.json", ".git"),
            init_options = {
                hostInfo = "neovim",
            },
            single_file_support = true,
            settings = {
                completions = {
                    completeFunctionCalls = true,
                },
                typescript = {
                    inlayHints = inlayHints,
                },
                javascript = {
                    inlayHints = inlayHints,
                },
            },
        })

        -- bash
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
        -- https://github.com/bash-lsp/bash-language-server
        -- NOTE: bashls integrates shellcheck by default

        lspconfig.bashls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { "sh" },
        })

        -- html, typescriptreact, javascriptreact, css, sass, scss, less, svelte, vue
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#emmet_ls
        -- https://github.com/aca/emmet-ls
        lspconfig.emmet_ls.setup({
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
        })

        -- json
        lspconfig.jsonls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "json", "jsonc" },
        })

        -- tailwindcss
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tailwindcss
        -- https://github.com/tailwindlabs/tailwindcss-intellisense
        -- NOTE: this requires tailwind to be setup properly in the poject directory
        -- lspconfig.tailwindcss.setup({
        --     capabilities = capabilities,
        --     on_attach = on_attach,
        -- })

        -- sql
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sqlls
        -- https://github.com/joe-re/sql-language-server
        lspconfig.sqlls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "sql-language-server", "up", "--method", "stdio" },
            filetypes = { "sql", "mysql" },
            root_dir = function()
                return vim.loop.cwd()
            end,
        })

        -- golang
        -- https://github.com/golang/tools/blob/master/gopls/doc/vim.md
        lspconfig.gopls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            root_dir = util.root_pattern("go.work", "go.mod", ".git"),
            settings = {
                gopls = {
                    -- source: https://github.com/chrisgrieser/nvim-lsp-endhints?tab=readme-ov-file#how-to-enable-inlay-hints-for-a-language
                    hints = {
                        rangeVariableTypes = true,
                        parameterNames = true,
                        constantValues = true,
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        compositeLiteralTypes = true,
                        functionTypeParameters = true,
                    },
                    completeUnimported = true,
                    usePlaceholders = false,
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                    gofumpt = true,
                },
            },
        })

        lspconfig.taplo.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig.cssls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                css = {
                    lint = {
                        unknownAtRules = "ignore", -- Ignore warnings for unknown @rules
                    },
                },
            },
        })

        -- graphql
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#graphql
        -- NOTE:
        -- temporary fix for  graphql lsp
        -- source: https://www.reddit.com/r/neovim/comments/1dfpp3m/for_anyone_whos_trying_to_get_graphql_ls_working/
        -- source: https://github.com/graphql/graphiql/issues/3538
        lspconfig.graphql.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "graphql-lsp", "server", "-m", "stream" },
            root_dir = lspconfig.util.root_pattern(".git", ".graphqlrc*", ".graphql.config.*", "graphql.config.*"),
        })

        -- harper
        -- source: https://writewithharper.com/docs/integrations/neovim
        lspconfig.harper_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "markdown" },
            settings = {
                ["harper-ls"] = {
                    userDictPath = "~/dict.txt",
                    codeActions = {
                        ForceStable = true,
                    },
                    linters = {
                        SentenceCapitalization = false,
                        ToDoHyphen = false,
                        -- SpellCheck = false,
                    },
                },
            },
        })
    end,
}
