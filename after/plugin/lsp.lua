-- LSP

-- NOTE: make sure mason-lspconfig is setup before lsp server configs are setup
-- Source: https://github.com/williamboman/mason.nvim/issues/124#issuecomment-1203211832

-- MASON CONFIG [[[

-- protective call so nothing breaks if lspconfig is missing
local status_ok, _ = pcall(require, 'mason-lspconfig')
if not status_ok then
    return
end

-- VARIABLES
local mason_setup = require("mason").setup
local mason_lsp = require("mason-lspconfig").setup

-- NOTE: setup calls required for both mason & mason-lspconfig
-- Source: https://github.com/williamboman/mason-lspconfig.nvim#setup

mason_setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

mason_lsp({
    -- NOTE: this section makes sure the below languages are available during first install when running :LSPInstall
    ensure_installed = {
        'vimls',
        'bashls',
        'pyright',
        'lua_ls',
        'ansiblels',
        'jsonls',
        'html'
    }
})

-- ]]]
-- LSP CONFIGS & KEYMAPS [[[

-- VARIABLE
local nvim_lsp = require('lspconfig')

-- NOTE: Use an on_attach function to only map the following keys after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local keymap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    keymap('rn', vim.lsp.buf.rename, 'ReName')
    keymap('ca', vim.lsp.buf.code_action, 'Code Action')

    keymap('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
    -- keymap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
    -- keymap('gr', require('telescope.builtin').lsp_references, 'Goto References')
    keymap('gI', vim.lsp.buf.implementation, 'Goto Implementation')
    -- keymap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
    keymap('<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', 'Format code')
    keymap('df', vim.diagnostic.open_float, 'Open Diagnostic Float')

    -- NOTE: `:help K` for why this keymap
    keymap('K', vim.lsp.buf.hover, 'Hover Documentation')
    keymap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    -- Disable Autoformat
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false

    -- Diagnostic Signs
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
end

-- NOTE: Language servers go here
local servers = {
    'vimls',
    'bashls',
    'pyright',
    'lua_ls',
    'ansiblels',
    'jsonls',
    'terraformls',
    'html'
}

for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        -- capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                },
                diagnostics = {
                    -- NOTE: Get the language server to recognize the `vim` global
                    globals = { 'vim' },
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    }
end

-- Capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require 'lspconfig'.bashls.setup {
    capabilities = capabilities
}

require 'lspconfig'.vimls.setup {
    capabilities = capabilities
}

require 'lspconfig'.pylsp.setup {
    capabilities = capabilities
}

require 'lspconfig'.ansiblels.setup {
    capabilities = capabilities
}

require 'lspconfig'.jsonls.setup {
    capabilities = capabilities
}

require 'lspconfig'.terraformls.setup {
    capabilities = capabilities,
}

require 'lspconfig'.html.setup {
    capabilities = capabilities,
}

vim.diagnostic.config({
    virtual_text = false
})

vim.o.updatetime = 250

-- Old command for float, not being used and replaced with the below command
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- NOTE: Show diagnostics in a pop-up window on hover
-- SOURCE: https://www.reddit.com/r/neovim/comments/mqspfo/is_there_any_way_to_hide_the_diagnostic_from/
_G.LspDiagnosticsPopupHandler = function()
    local current_cursor = vim.api.nvim_win_get_cursor(0)
    local last_popup_cursor = vim.w.lsp_diagnostics_last_cursor or { nil, nil }

    -- Show the popup diagnostics window,
    -- but only once for the current cursor location (unless moved afterwards).
    if not (current_cursor[1] == last_popup_cursor[1] and current_cursor[2] == last_popup_cursor[2]) then
        vim.w.lsp_diagnostics_last_cursor = current_cursor
        vim.diagnostic.open_float(0, { scope = "cursor" }) -- for neovim 0.6.0+, replaces show_{line,position}_diagnostics
    end
end
vim.cmd [[
augroup LSPDiagnosticsOnHover
  autocmd!
  autocmd CursorHold *   lua _G.LspDiagnosticsPopupHandler()
augroup END
]]

-- ]]]

-- TEST:
-- print("Hello from AFTER/LSP")
