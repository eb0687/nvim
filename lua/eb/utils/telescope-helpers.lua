local M = {}

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- https://joseustra.com/blog/reloading-neovim-config-with-telescope/?source=ustrajunior.com
-- NOTE: probably not needed any longer as telescope has as built in version
-- BUG: this does not reload modules but does show the notification
function M.reload()
    -- Telescope will give us something like ju/colors.lua,
    -- so this function convert the selected entry to
    -- the module name: ju.colors
    local function get_module_name(s)
        local module_name

        module_name = s:gsub("%.lua", "")
        module_name = module_name:gsub("%/", ".")
        module_name = module_name:gsub("%.init", "")

        return module_name
    end

    local prompt_title = "~ neovim modules ~"

    -- sets the path to the lua folder
    local path = "~/.config/nvim/lua"

    local opts = {
        prompt_title = prompt_title,
        cwd = path,

        attach_mappings = function(_, map)
            -- Adds a new map to ctrl+e.
            map("i", "<c-e>", function(_)
                -- these two a very self-explanatory
                local entry = require("telescope.actions.state").get_selected_entry()
                local name = get_module_name(entry.value)

                -- call the helper method to reload the module
                -- and give some feedback
                R(name)
                P(name .. " RELOADED!!!")
            end)

            return true
        end,
    }

    -- call the builtin method to list files
    require("telescope.builtin").find_files(opts)
end

-- https://github.com/creativecreature/dotfiles/blob/master/nvim/lua/plugins/telescope.lua
-- NOTE: allow u to select results in a telescope window using the TAB key and
-- the selections to a quickfix list using the <C-s> key
function M.multi_select(prompt_bufnr)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local num_selections = table.getn(picker:get_multi_selection())

    if num_selections > 1 then
        -- actions.file_edit throws - context of picker seems to change
        --actions.file_edit(prompt_bufnr)
        actions.send_selected_to_qflist(prompt_bufnr)
        actions.open_qflist()
    else
        actions.file_edit(prompt_bufnr)
    end
end

return M
