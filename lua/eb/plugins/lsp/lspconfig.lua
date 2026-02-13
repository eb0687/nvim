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
        -- NOTE: Capabilities required for the visualstudio lsps (css, html, etc)
        -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssls
        capabilities.textDocument.completion.completionItem.snippetSupport = true

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
            float = {
                border = "rounded",
            },
        })

        -- NOTE: disables the default keymap for neovim native lsp
        vim.keymap.del("n", "grr")
        vim.keymap.del("n", "gra")
        vim.keymap.del("n", "gri")
        vim.keymap.del("n", "grn")
        vim.keymap.del("n", "grt")

        -- NOTE: enable LSPs here
        vim.lsp.enable("lua_ls")
        vim.lsp.enable("rust_analyzer")
        vim.lsp.enable("gopls")
        vim.lsp.enable("cssls")
        vim.lsp.enable("emmet_language_server")
        vim.lsp.enable("ts_ls")
        vim.lsp.enable("bashls")
        vim.lsp.enable("vimls")
        vim.lsp.enable("taplo")
        vim.lsp.enable("gh_actions_ls")
        vim.lsp.enable("biome")
        vim.lsp.enable("graphql")
        vim.lsp.enable("ansiblels")
        vim.lsp.enable("pyright")
        -- NOTE: manually installed via npm
        vim.lsp.enable("jsonls")
        vim.lsp.enable("sqlls")
        vim.lsp.enable("hyprls")

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

            vim.keymap.set({ "n", "v" }, "<leader>ca", function()
                vim.lsp.buf.code_action()
            end, { desc = "code action" })

            keymap("gi", function()
                vim.lsp.buf.implementation()
            end, "Goto Implementation")

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

            -- Disable tsserver autoformat
            if client.name == "tsserver" or client.name == "ts_ls" then
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

        vim.lsp.config("*", {
            capabilities = capabilities,
        })

        local lsp_attach_group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true })
        vim.api.nvim_create_autocmd("LspAttach", {
            group = lsp_attach_group,
            callback = function(ev)
                local bufnr = ev.buf
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                if not client then
                    return
                end
                on_attach(client, ev.buf)

                if vim.b[bufnr].format_cmd_created then
                    return
                end
                vim.b[bufnr].format_cmd_created = true
                vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
                    require("conform").format({
                        bufnr = bufnr,
                        lsp_fallback = true,
                        async = false,
                        timeout_ms = 1000,
                    })
                end, { desc = "Format current buffer with LSP" })
            end,
        })

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
