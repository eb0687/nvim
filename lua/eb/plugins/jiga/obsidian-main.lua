return {
    "obsidian-nvim/obsidian.nvim",
    -- version = "*", -- use latest release, remove to use latest commit
    enabled = true,
    ft = "markdown",
    config = function()
        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_normal = custom_helpers.keymap_normal
        local keymap_visual = custom_helpers.keymap_visual
        local obsidian = require("obsidian")

        ---@module 'obsidian'
        ---@type obsidian.config
        obsidian.setup({
            completion = {
                min_chars = 2,
            },
            link = {
                style = "markdown",
            },
            templates = {
                folder = "templates",
                date_format = "%Y-%m-%d (%a)",
                time_format = "%H:%M",
            },
            legacy_commands = false,
            picker = {
                name = "mini.pick",
            },
            unique_note = { format = "${title}-${date}-${time}" },
            ui = {
                enable = false,
            },
            workspaces = {
                {
                    name = "perosnal",
                    path = vim.fn.expand("~/Documents/the_vault"),
                },
            },
            footer = {
                enabled = false,
            },
        })

        keymap_normal(
            "<leader>on",
            ":Obsidian template<CR>",
            "OBSIDIAN",
            true,
            -- this will insert the template under the cursor position
            "Convert note template and remove leading white space"
        )

        keymap_normal(
            "<leader>of",
            ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>",
            "OBSIDIAN",
            true,
            "Strip date from note title & replace dashes with spaces"
        )

        keymap_normal("<leader>oq", ":Obsidian quick_switch<CR>", "OBSIDIAN", true, "Quickly switch between notes")
        keymap_normal("<leader>odd", ":!rm '%:p'<CR>:bd<CR>", "OBSIDIAN", true, "Delete note from inbox")
        keymap_visual(
            "<leader>ol",
            ":ObsidianLinkNew",
            "OBSIDIAN",
            true,
            "Create a new note and link to a visual selection (optional args)"
        )
    end,
}
