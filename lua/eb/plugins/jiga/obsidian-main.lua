-- NOTE: defaults are here: https://github.com/obsidian-nvim/obsidian.nvim/blob/main/lua/obsidian/config/default.lua
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
                auto_update = true,
            },
            note_id_func = require("obsidian.builtin").title_id,
            ---@diagnostic disable-next-line: missing-fields
            templates = {
                folder = "templates",
                date_format = "%Y-%m-%d (%a)",
                time_format = "%H:%M",
            },
            legacy_commands = false,
            picker = {
                name = "mini.pick",
            },
            unique_note = {
                format = require("obsidian.builtin").zettel_id,
                template = "templates/quicknotes-template.md",
            },
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
            frontmatter = {
                func = function(note)
                    local fm = require("obsidian.builtin").frontmatter(note)
                    fm.id = nil
                    fm.aliases = nil
                    return fm
                end,
            },
        })

        keymap_normal(
            "<leader>on",
            ":Obsidian template<CR>",
            "OBSIDIAN",
            true,
            "Convert note template and remove leading white space"
        )

        keymap_normal(
            "<leader>of",
            ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>",
            "OBSIDIAN",
            true,
            "Strip date from note title & replace dashes with spaces"
        )

        keymap_visual(
            "<leader>ol",
            ":Obsidian link_new<CR>",
            "OBSIDIAN",
            true,
            "Create a new note from a visual selection"
        )

        keymap_normal(
            "<leader>oq",
            ":Obsidian quick_switch<CR>",
            "OBSIDIAN",
            true,
            "Quickly switch between notes using the picker"
        )

        -- TODO: make this safer by prompting the user to confirm deletion of the note
        keymap_normal(
            "<leader>odd",
            ":!rm '%:p'<CR>:bd<CR>",
            "OBSIDIAN",
            true,
            "Delete a note from the obisidian inbox"
        )

        keymap_normal(
            "<leader>oo",
            ":Obsidian open<CR>",
            "OBSIDIAN",
            true,
            "Open the current note inside the Obsidian app"
        )

        vim.api.nvim_create_autocmd("User", {
            pattern = "ObsidianNoteWritePost",
            callback = function(ev)
                require("conform").format({
                    bufnr = ev.buf,
                    formatters = { "prettier", "injected" },
                })
            end,
        })
    end,
}
