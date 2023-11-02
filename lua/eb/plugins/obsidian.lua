--        _         _     _ _
--   ___ | |__  ___(_) __| (_) __ _ _ __
--  / _ \| '_ \/ __| |/ _` | |/ _` | '_ \
-- | (_) | |_) \__ \ | (_| | | (_| | | | |
--  \___/|_.__/|___/_|\__,_|_|\__,_|_| |_|
-- https://github.com/epwalsh/obsidian.nvim

-- NOTE:
-- this plugin is not loaded at startup and would require manually loading

return {

    'epwalsh/obsidian.nvim',
    lazy = true,
    event = {
        "BufReadPre " .. vim.fn.expand "~" .. "Documents/the_vault/**.md",
        "BufNewFile " .. vim.fn.expand "~" .. "Documents/the_vault/**.md",
        "BufEnter " .. vim.fn.expand "~" .. "Documents/the_vault/**.md",
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
    },

    config = function()
        local obsidian = require('obsidian')

        -- NOTE: this function opens hyperlinks in web browsers
        local follow_url = function(url)
            vim.fn.jobstart({
                "xdg-open", url
            })
        end

        -- NOTE: tihs function will rename a new note in obisidan based on whether a title was given or not
        local new_note_id = function(title)
            local suffix = ""
            if title ~= nil then
                suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
                -- NOTE: add randomization if no title is entered
                suffix = tostring(os.time()) .. string.char(math.random(65, 90)) .. '-' .. 'notitle'
            end
            return suffix
        end

        -- SETUP
        obsidian.setup({
            dir = "~/Documents/the_vault/",
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
            }
        })

        -- NOTE: this is a temporary fix for treesitter highlight not being enabled by default in markdown files
        vim.api.nvim_create_autocmd(
            { "BufEnter", "BufWinEnter" },
            { pattern = { "*.md" }, command = "TSEnable highlight" }
        )

        -- KEYMAPS

        local keymap_normal = function(keys, func, desc)
            if desc then
                desc = 'Obsidian: ' .. desc
            end

            vim.keymap.set('n', keys, func, { desc = desc })
        end

        local keymap_visual = function(keys, func, desc)
            if desc then
                desc = 'Obsidian: ' .. desc
            end

            vim.keymap.set('v', keys, func, { desc = desc })
        end

        keymap_normal("gf", ":ObsidianFollowLink<CR>",
            'follow Obsidian link')
        keymap_normal('<leader>oo', ':ObsidianOpen ',
            'Open note in Obsidian (optional args)')
        keymap_normal('<leader>on', ':ObsidianNew ',
            'Create new note in Obsidian (optional args)')
        keymap_normal('<leader>of', ':ObsidianSearch ',
            'Search obsidian vault using ripgrep (optional args)')
        keymap_normal('<leader>ot', ':ObsidianTemplate<CR>',
            'Import from Obsidian template(optional args)')
        keymap_normal('<leader>oq', ':ObsidianQuickSwitch<CR>',
            'Quickly switch between notes')
        keymap_normal('<leader>ob', ':ObsidianBacklinks<CR>',
            'Open Obsidian backlinks')
        keymap_normal('<leader>od', ':ObsidianToday<CR>',
            'Create new daily note')
        keymap_visual('<leader>ol', ':ObsidianLink ',
            'Link an inline visual selection to an existing note (optional args)')
        keymap_visual('<leader>Ol', ':ObsidianLinkNew ',
            'Create a new note and link to a visual selection (optional args)')

        -- TEST:
        -- print("Hello from lazy obsidian")
    end
}
