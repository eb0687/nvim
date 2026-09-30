return {
    cmd = { "docker-language-server", "start", "--stdio" },
    filetypes = { "dockerfile", "yaml.docker-compose", "hcl.docker-bake" },
    initialization_options = {
        telemetry = "off",
    },
    root_markers = {
        "Dockerfile",
        "docker-compose.yaml",
        "docker-compose.yml",
        "compose.yaml",
        "compose.yml",
        "docker-bake.json",
        "docker-bake.hcl",
    },
}
