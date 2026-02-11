-- SOURCE: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
-- SOURCE: https://github.com/typescript-language-server/typescript-language-server

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

return {
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
}
