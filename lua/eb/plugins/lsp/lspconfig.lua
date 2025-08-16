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

        local capabilities = vim.lsp.protocol.make_client_capabilities()

        capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))

        capabilities = vim.tbl_deep_extend("force", capabilities, {
            textDocument = {
                foldingRange = {
                    dynamicRegistration = false,
                    lineFoldingOnly = true,
                },
            },
        })

        -- Diagnostics
        vim.diagnostic.config({
            -- virtual_lines = { current_line = true },
            virtual_lines = false,
            underline = true,
            virtual_text = {
                current_line = false,
                virt_text_pos = "eol",
                source = true,
            },
        })

        vim.diagnostic.open_float({ border = "rounded" })

        -- NOTE: disables the default keymap for nepvim native lsp
        vim.keymap.del("n", "grr")
        vim.keymap.del("n", "gra")
        vim.keymap.del("n", "gri")
        vim.keymap.del("n", "grn")
        vim.keymap.del("n", "grt")

        -- NOTE:
        -- Capabilities required for the visualstudio lsps (css, html, etc)
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssls
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        -- NOTE: Use an on_attach function to only map the following keys after the language server attaches to the current buffer
        local on_attach = function(client, bufnr)
            local keymap = function(keys, func, desc)
                if desc then
                    desc = "LSP: " .. desc
                end

                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc, silent = true })
                -- NOTE: if inlay hints on startup is desired uncomment the below line
                -- vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end

            -- KEYMAPS
            keymap("]d", function()
                vim.diagnostic.jump({
                    count = 1,
                    float = false,
                })
            end, "Go to previous diagnostic message")

            keymap("[d", function()
                vim.diagnostic.jump({
                    count = -1,
                    float = false,
                })
            end, "Go to next diagnostic message")

            -- using defaults Ctrl+wd
            -- keymap("df", function()
            --     vim.diagnostic.open_float({
            --         border = "rounded",
            --     })
            -- end, "Open diagnostic in a float")

            keymap("rn", function()
                vim.lsp.buf.rename()
            end, "Rename")

            keymap("K", function()
                vim.lsp.buf.hover({
                    border = { "", "─", "╮", "│", "╯", "─", "╰", "│" },
                    max_height = 25,
                    max_width = 120,
                })
            end, "Hover documentation")

            keymap("<leader>ca", function()
                vim.lsp.buf.code_action()
            end, "Code action")

            vim.keymap.set({ "n", "v" }, "<leader>ca", function()
                vim.lsp.buf.code_action()
            end, { desc = "code action" })

            keymap("gi", function()
                vim.lsp.buf.implementation()
            end, "Goto Implementation")

            -- keymap("gd", ":Pick lsp scope='definition'<CR>", "Goto Definition")
            keymap("gd", function()
                vim.lsp.buf.definition()
            end, "Goto Definition")
            keymap("gr", ":Pick lsp scope='references'<CR>", "Goto References")
            keymap("ds", ":Pick lsp scope='document_symbol'<CR>", "Goto References")

            keymap("<space>lf", '<cmd>lua require("conform").format()<CR>', "Format code")

            -- NOTE: `:help K` for why this keymap
            keymap("<leader>D", function()
                vim.lsp.buf.signature_help()
            end, "Signature Documentation")

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

            -- Diagnostic Signs
            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.HINT] = " ",
                        [vim.diagnostic.severity.INFO] = " ",
                    },
                },
            })

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
            capabilities = capabilities,
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
        -- NOTE: i installed lua-ls-server manually and symlinked in to ~/.local/bin
        -- https://github.com/LuaLS/lua-language-server/wiki/Getting-Started
        lspconfig.lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
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
                    completion = {
                        callSnippet = "Replace",
                        workspaceWord = true,
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

        -- NOTE: installed manually
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
            cmd = { "bash-language-server", "start" },
            filetypes = { "sh" },
        })

        -- html, typescriptreact, javascriptreact, css, sass, scss, less, svelte, vue
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#emmet_ls
        -- https://github.com/aca/emmet-ls
        -- lspconfig.emmet_ls.setup({
        --     capabilities = capabilities,
        --     on_attach = on_attach,
        --     filetypes = {
        --         "html",
        --         "typescriptreact",
        --         "javascriptreact",
        --         "javascript",
        --         "css",
        --         "sass",
        --         "scss",
        --         "less",
        --         "svelte",
        --         "vue",
        --     },
        -- })

        -- NOTE: installed manually
        -- https://github.com/olrtg/emmet-language-server?tab=readme-ov-file
        lspconfig.emmet_language_server.setup({
            filetypes = {
                "css",
                "eruby",
                "html",
                "javascript",
                "javascriptreact",
                "less",
                "sass",
                "scss",
                "pug",
                "typescriptreact",
            },
            -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
            -- **Note:** only the options listed in the table are supported.
            -- TODO: look up how to set these properly
            init_options = {
                ---@type table<string, string>
                includeLanguages = {},
                --- @type string[]
                excludeLanguages = {},
                --- @type string[]
                extensionsPath = {},
                --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
                preferences = {},
                --- @type boolean Defaults to `true`
                showAbbreviationSuggestions = true,
                --- @type "always" | "never" Defaults to `"always"`
                showExpandedAbbreviation = "always",
                --- @type boolean Defaults to `false`
                showSuggestionsAsSnippets = false,
                --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
                syntaxProfiles = {},
                --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
                variables = {},
            },
        })

        -- json
        -- NOTE: manually installed via npm
        -- SOURCE: https://github.com/hrsh7th/vscode-langservers-extracted
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
                ---@diagnostic disable-next-line: undefined-field
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
                    -- SOURCE: https://github.com/chrisgrieser/nvim-lsp-endhints?tab=readme-ov-file#how-to-enable-inlay-hints-for-a-language
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
        -- SOURCE: https://www.reddit.com/r/neovim/comments/1dfpp3m/for_anyone_whos_trying_to_get_graphql_ls_working/
        -- SOURCE: https://github.com/graphql/graphiql/issues/3538
        lspconfig.graphql.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "graphql-lsp", "server", "-m", "stream" },
            root_dir = lspconfig.util.root_pattern(".graphqlrc*", ".graphql.config.*", "graphql.config.*"),
        })

        -- lspconfig.marksman.setup({
        --     capabilities = capabilities,
        --     on_attach = on_attach,
        --     root_dir = lspconfig.util.root_pattern(".git", ".marksman.toml"),
        -- })

        -- NOTE: installed rust-analyzer using rustup
        -- rustup component add rust-analyzer
        lspconfig.rust_analyzer.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                ["rust_analyzer"] = {
                    imports = {
                        granularity = {
                            group = "module",
                        },
                        prefix = "self",
                    },
                    procMacro = {
                        enable = true,
                    },
                    assist = {
                        importEnforceGranularity = true,
                        importPrefix = "crate",
                    },
                    cargo = {
                        buildScripts = {
                            enable = true,
                        },
                        allFeatures = true,
                    },
                    checkOnSave = {
                        command = "clippy",
                    },
                    inlayHints = {
                        locationLinks = false,
                    },
                    diagnostics = {
                        enable = true,
                        experimental = {
                            enable = true,
                        },
                    },
                },
            },
        })

        -- harper
        -- SOURCE: https://writewithharper.com/docs/integrations/neovim
        -- lspconfig.harper_ls.setup({
        --     capabilities = capabilities,
        --     on_attach = on_attach,
        --     filetypes = { "markdown" },
        --     settings = {
        --         ["harper-ls"] = {
        --             userDictPath = "~/dict.txt",
        --             codeActions = {
        --                 ForceStable = true,
        --             },
        --             linters = {
        --                 SentenceCapitalization = false,
        --                 ToDoHyphen = false,
        --                 -- SpellCheck = false,
        --             },
        --             markdown = {
        --                 IgnoreLinkTitle = true,
        --             },
        --         },
        --     },
        -- })

        -- SOURCE: https://jli69.github.io/blog/2025/06/28/neovim-with-godot.html
        -- NOTE: For using Godot's debugger look into this link:
        -- NOTE: https://simondalvai.org/blog/godot-neovim/
        local port = os.getenv("GDScript_Port") or "6005"
        local cmd = vim.lsp.rpc.connect("127.0.0.1", tonumber(port))
        lspconfig.gdscript.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            name = "Godot",
            cmd = cmd,
            root_dir = vim.fs.dirname(vim.fs.find({ "project.godot", ".git" }, { upward = true })[1]),
        })
    end,
}
