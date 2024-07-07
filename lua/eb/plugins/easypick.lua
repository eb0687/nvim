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
                },
            },
        })
    end,
}
