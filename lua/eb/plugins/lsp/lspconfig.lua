--  _                            __ _
-- | |___ _ __   ___ ___  _ __  / _(_) __ _
-- | / __| '_ \ / __/ _ \| '_ \| |_| |/ _` |
-- | \__ \ |_) | (_| (_) | | | |  _| | (_| |
-- |_|___/ .__/ \___\___/|_| |_|_| |_|\__, |
--       |_|                          |___/
-- https://github.com/neovim/nvim-lspconfig

-- TODO: install trouble.nvim using this guide: https://youtu.be/6pAG3BHurdM?t=4307https://youtu.be/6pAG3BHurdM?t=4307
-- TODO: after updating lspconfig there will be breaking changes, refer to this link for troubleshooting tips
-- TODO: https://www.reddit.com/r/neovim/comments/1nmh99k/beware_the_old_nvimlspconfig_setup_api_is/
-- TODO: https://xnacly.me/posts/2025/neovim-lsp-changes/
-- TODO: check the vim.lsp.config in the docs

return {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
        { "saghen/blink.cmp" },
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
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
        end

        -- LANGUAGE SERVER CONFIGURATION
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

        local lsps = {
            -- SOURCE: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#vimls
            -- SOURCE: https://github.com/iamcco/vim-language-server
            { "vimls" },
            { "taplo" },

            -- SOURCE: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#graphql
            -- NOTE:
            -- temporary fix for  graphql lsp
            -- SOURCE: https://www.reddit.com/r/neovim/comments/1dfpp3m/for_anyone_whos_trying_to_get_graphql_ls_working/
            -- SOURCE: https://github.com/graphql/graphiql/issues/3538
            {
                "graphql",
                {
                    cmd = { "graphql-lsp", "server", "-m", "stream" },
                    -- root_dir = lspconfig.util.root_pattern(".graphqlrc*", ".graphql.config.*", "graphql.config.*"),
                    -- TODO: need to test this
                    root_dir = vim.fs.dirname(vim.fs.find({
                        ".graphqlrc",
                        ".graphql.config.*",
                        "graphql.config.*",
                    }, { upward = true })[1]),
                },
            },
            {
                "cssls",
                {
                    settings = {
                        css = {
                            lint = {
                                unknownAtRules = "ignore", -- Ignore warnings for unknown @rules
                            },
                        },
                    },
                },
            },

            -- SOURCE: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ansiblels
            -- SOURCE: https://github.com/ansible/ansible-language-server
            -- TODO: ansible lsp is not working, need to fix
            {
                "ansiblels",
                {
                    filetypes = { "yaml.ansible" },
                    single_file_support = false,
                    -- root_dir = lspconfig.util.root_pattern("roles", "playbooks", "ansible"),
                },
            },

            -- NOTE: installed rust-analyzer using rustup
            -- NOTE: rustup component add rust-analyzer
            {
                "rust_analyzer",
                {
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
                },
            },

            -- SOURCE: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
            -- SOURCE: https://github.com/luals/lua-language-server
            -- NOTE: i installed lua-ls-server manually and symlinked in to ~/.local/bin
            {
                "lua_ls",
                {
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
                },
            },

            -- SOURCE: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright
            -- SOURCE: https://github.com/microsoft/pyright
            {
                "pyright",
                {
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
                },
            },

            -- SOURCE: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
            -- SOURCE: https://github.com/typescript-language-server/typescript-language-server
            {
                "ts_ls",
                {
                    filetypes = {
                        "javascript",
                        "javascriptreact",
                        "javascript.jsx",
                        "typescript",
                        "typescriptreact",
                        "typescript.tsx",
                    },
                    -- root_dir = lspconfig.util.root_pattern("jsconfig.json", "package.json", "tsconfig.json", ".git"),
                    -- TODO: need to test this
                    root_dir = vim.fs.dirname(vim.fs.find({
                        "jsconfig.json",
                        "package.json",
                        "tsconfig.json",
                        ".git",
                    }, { upward = true })[1]),
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
                },
            },

            -- NOTE: bashls integrates shellcheck by default
            -- SOURCE: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
            -- SOURCE: https://github.com/bash-lsp/bash-language-server
            {
                "bashls",
                {
                    cmd = { "bash-language-server", "start" },
                    filetypes = { "sh", "bash" },
                },
            },

            -- NOTE: installed manually
            -- SOURCE: https://github.com/olrtg/emmet-language-server?tab=readme-ov-file
            {
                "emmet_language_server",
                {
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
                    -- NOTE: only the options listed in the table are supported.
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
                },
            },

            -- NOTE: manually installed via npm
            -- SOURCE: https://github.com/hrsh7th/vscode-langservers-extracted
            {
                "jsonls",
                {
                    filetypes = { "json", "jsonc" },
                },
            },

            -- SOURCE: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sqlls
            -- SOURCE: https://github.com/joe-re/sql-language-server
            {
                "sqlls",
                {
                    cmd = { "sql-language-server", "up", "--method", "stdio" },
                    filetypes = { "sql", "mysql" },
                    root_dir = function()
                        ---@diagnostic disable-next-line: undefined-field
                        return vim.loop.cwd()
                    end,
                },
            },

            -- SOURCE: https://github.com/golang/tools/blob/master/gopls/doc/vim.md
            {
                "gopls",
                {
                    cmd = { "gopls" },
                    filetypes = { "go", "gomod", "gowork", "gotmpl" },
                    -- root_dir = util.root_pattern("go.work", "go.mod", ".git"),
                    root_dir = vim.fs.dirname(vim.fs.find({
                        "go.work",
                        "go.mod",
                        ".git",
                    }, { upward = true })[1]),
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
                },
            },
        }

        for _, lsp in pairs(lsps) do
            local name, config = lsp[1], lsp[2]
            vim.lsp.enable(name)
            config = config or {}
            config.on_attach = on_attach
            config.capabilities = capabilities
            vim.lsp.config(name, config)
        end

        -- SOURCE: https://jli69.github.io/blog/2025/06/28/neovim-with-godot.html
        -- NOTE: For using Godot's debugger look into this link:
        -- NOTE: https://simondalvai.org/blog/godot-neovim/
        local port = os.getenv("GDScript_Port") or "6005"
        local cmd = vim.lsp.rpc.connect("127.0.0.1", tonumber(port))
        local godot_helper = require("eb.utils.godot_helper")

        if os.getenv("WSL_DISTRO_NAME") ~= nil then
            vim.lsp.config("gdscript", {
                cmd = { "godot-wsl-lsp", "--experimentalFastPathConversion" },
                on_attach = on_attach,
                capabilities = capabilities,
            })
            vim.lsp.enable("gdscript")
        else
            godot_helper.start_godot_server()
            vim.lsp.config("gdscript", {
                on_attach = on_attach,
                capabilities = capabilities,
                name = "Godot",
                cmd = cmd,
                root_dir = vim.fs.dirname(vim.fs.find({
                    "project.godot",
                    ".git",
                }, { upward = true })[1]),
            })
            vim.lsp.enable("gdscript")
        end
    end,
}
