return {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml" },
    root_markers = { ".git" },
    settings = {
        yaml = {
            completion = true,
            hover = true,
            validate = true,
            schemaStore = {
                enable = true,
                url = "https://www.schemastore.org/api/json/catalog.json",
            },
            schemas = {
                kubernetes = {
                    "**/k8s/**/*.yaml",
                    "**/k8s/**/*.yml",
                    "**/kubernetes/**/*.yaml",
                    "**/kubernetes/**/*.yml",
                    "**/manifests/**/*.yaml",
                    "**/manifests/**/*.yml",
                    "**/charts/**/*.yaml",
                    "**/charts/**/*.yml",
                },
            },
        },
    },
}
