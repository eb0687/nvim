-- NOTE: installed rust-analyzer using rustup
-- NOTE: rustup component add rust-analyzer

return {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
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
}
