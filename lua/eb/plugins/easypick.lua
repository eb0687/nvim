-- easypick.nvim
-- https://github.com/axkirillov/easypick.nvim

return {
    "axkirillov/easypick.nvim",
    cmd = "Easypick",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
        local easypick = require("easypick")

        easypick.setup({
            pickers = {
                {
                    -- this will only work if not inside an existing git repo
                    name = "Dotbare",
                    command = "dotbare ls-files",
                    previewer = easypick.previewers.default(),
                    opts = require("telescope.themes").get_ivy({}),
                },
                {
                    -- this will only work if not inside an existing git repo
                    name = "Dotbare unstagged files",
                    command = "dotbare diff --name-only",
                    previewer = easypick.previewers.file_diff(),
                    opts = require("telescope.themes").get_ivy({}),
                },
                {
                    -- Show staged files ready to be commited only
                    name = "Dotbare staged files",
                    command = "dotbare diff --name-only --staged",
                    opts = require("telescope.themes").get_ivy({}),
                },
                {
                    -- Show staged files ready to be commited only
                    name = "Staged files",
                    command = "git diff --name-only --staged",
                    action = easypick.actions.nvim_commandf("Git commit %s"),
                    opts = require("telescope.themes").get_ivy({}),
                },
                {
                    -- Show unstagged files only
                    name = "Unstagged files",
                    command = "git diff --name-only",
                    previewer = easypick.previewers.file_diff(),
                    opts = require("telescope.themes").get_ivy({}),
                },
            },
        })
    end,
}
