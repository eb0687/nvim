--        _         _     _ _
--   ___ | |__  ___(_) __| (_) __ _ _ __
--  / _ \| '_ \/ __| |/ _` | |/ _` | '_ \
-- | (_) | |_) \__ \ | (_| | | (_| | | | |
--  \___/|_.__/|___/_|\__,_|_|\__,_|_| |_|
-- https://github.com/epwalsh/obsidian.nvim

-- NOTE:
-- this plugin is not loaded at startup and would require manually loading
-- TODO: consider creating a bash script to organize notes in the zettle folder
-- https://github.com/agalea91/dotfiles/blob/97f0eca4cc0c4c0ff1f7b025bbb32f394d427cb5/bin/og

return {

    "epwalsh/obsidian.nvim",
    version = "*",
    ft = "markdown",
    event = {
        "BufReadPre " .. vim.fn.expand("~") .. "Documents/the_vault/**.md",
        "BufNewFile " .. vim.fn.expand("~") .. "Documents/the_vault/**.md",
        "BufEnter " .. vim.fn.expand("~") .. "Documents/the_vault/**.md",
        "BufReadPre " .. "/mnt/d/the_vault/**.md",
        "BufNewFile " .. "/mnt/d/the_vault/**.md",
        "BufEnter " .. "/mnt/d/the_vault/**.md",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    config = function()
        local obsidian = require("obsidian")
        local custom_helpers = require("eb.utils.custom_helpers")
        local keymap_normal = custom_helpers.keymap_normal
        local keymap_visual = custom_helpers.keymap_visual
        local utils = require("eb.utils.custom_helpers")
        local hostname = utils.get_hostname()

        local function get_obsidian_dir()
            if hostname == "eb-t490" then
                return "~/Documents/the_vault/"
            elseif hostname == "JIGA" then
                return "/mnt/d/the_vault/"
            end
        end

        -- NOTE: this function opens hyperlinks in web browsers
        local follow_url = function(url)
            vim.fn.jobstart({
                "xdg-open",
                url,
            })
        end

        -- NOTE: tihs function will rename a new note in obisidan based on whether a title was given or not
        local new_note_id = function(title)
            local suffix = ""
            if title ~= nil then
                suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
                -- NOTE: add randomization if no title is entered
                suffix = tostring(os.time()) .. string.char(math.random(65, 90)) .. "-" .. "notitle"
            end
            return suffix
        end

        -- SETUP
        obsidian.setup({
            workspaces = {
                {
                    name = "eb-vault",
                    path = get_obsidian_dir(),
                },
            },
            -- dir = "~/Documents/the_vault/",
            daily_notes = {
                folder = "dailies",
            },
            follow_url_func = follow_url,
            disable_frontmatter = true, -- disables the autogenerated header when creating new files
            note_id_func = new_note_id,
            templates = {
                subdir = "templates",
                date_format = "%Y-%m-%d (%a)",
                time_format = "%H:%M",
            },
            completion = {
                nvim_cmp = true,
            },
        })

        keymap_normal("gf", ":ObsidianFollowLink<CR>", "OBSIDIAN", true, "follow Obsidian link")
        keymap_normal("<leader>oo", ":ObsidianOpen ", "OBSIDIAN", true, "Open note in Obsidian (optional args)")
        keymap_normal("<leader>on", ":ObsidianNew ", "OBSIDIAN", true, "Create new note in Obsidian (optional args)")
        keymap_normal("<leader>oq", ":ObsidianQuickSwitch<CR>", "OBSIDIAN", true, "Quickly switch between notes")
        keymap_normal("<leader>ob", ":ObsidianBacklinks<CR>", "OBSIDIAN", true, "Open Obsidian backlinks")
        keymap_normal("<leader>odn", ":ObsidianToday<CR>", "OBSIDIAN", true, "Create new daily note")
        keymap_normal("<leader>odd", ":!rm '%:p'<CR>:bd<CR>", "OBSIDIAN", true, "Delete note from inbox")
        keymap_normal(
            "<leader>of",
            ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>",
            "OBSIDIAN",
            true,
            "Strip date from note title & replace dashes with spaces"
        )
        keymap_normal(
            "<leader>ot",
            ":ObsidianTemplate<CR>",
            "OBSIDIAN",
            true,
            "Import from Obsidian template(optional args)"
        )
        keymap_normal(
            "<leader>on",
            ":ObsidianTemplate neovim-template<CR> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>",
            "OBSIDIAN",
            true,
            -- this will insert the template under the cursor position
            "Convert note template and remove leading white space"
        )
        -- keymap_visual(
        --     "<leader>ol",
        --     ":ObsidianLink",
        --     "OBSIDIAN",
        --     true,
        --     "Link an inline visual selection to an existing note (optional args)"
        -- )
        keymap_visual(
            "<leader>ol",
            ":ObsidianLinkNew",
            "OBSIDIAN",
            true,
            "Create a new note and link to a visual selection (optional args)"
        )

        if hostname == "JIGA" then
            keymap_normal(
                "<leader>ok",
                ":!mv '%:p' /mnt/d/the_vault/zettel<CR>:bd<CR>",
                "OBSIDIAN",
                true,
                "Move note from inbox to Zettel for processing"
            )
        elseif hostname == "eb-t490" then
            keymap_normal(
                "<leader>ok",
                ":!mv '%:p' ~/Documents/the_vault/zettel<CR>:bd<CR>",
                "OBSIDIAN",
                true,
                "Move note from inbox to Zettel for processing"
            )
        end

        -- TEST:
        -- print("Hello from lazy obsidian")
    end,
}
