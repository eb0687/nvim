vim.filetype.add({
    pattern = {
        [".*/roles/[^/]+/tasks/.*%.ya?ml"] = "yaml.ansible",
        [".*/roles/[^/]+/handlers/.*%.ya?ml"] = "yaml.ansible",
        [".*/roles/[^/]+/defaults/.*%.ya?ml"] = "yaml.ansible",
        [".*/roles/[^/]+/vars/.*%.ya?ml"] = "yaml.ansible",
        [".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
    },
})
