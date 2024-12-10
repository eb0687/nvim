local M = {}

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local builtin = require("telescope.builtin")

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

-- https://medium.com/@jogarcia/delete-buffers-on-telescope-21cc4cf61b63
-- NOTE: delete buffers from telescope buffer list
M.buffer_searcher = function()
    builtin.buffers({
        sort_mru = true,
        sort_lastused = true,
        initial_mode = "normal",
        ignore_current_buffer = false,
        show_all_buffers = true,
    })
end

function M.document_symbols_for_selected(prompt_bufnr)
    -- local action_state = require("telescope.actions.state")
    -- local actions = require("telescope.actions")
    local entry = action_state.get_selected_entry()

    if entry == nil then
        print("No file selected")
        return
    end

    actions.close(prompt_bufnr)

    vim.schedule(function()
        local bufnr = vim.fn.bufadd(entry.path)
        vim.fn.bufload(bufnr)

        local params = { textDocument = vim.lsp.util.make_text_document_params(bufnr) }

        vim.lsp.buf_request(bufnr, "textDocument/documentSymbol", params, function(err, result, _, _)
            if err then
                print("Error getting document symbols: " .. vim.inspect(err))
                return
            end

            if not result or vim.tbl_isempty(result) then
                print("No symbols found")
                return
            end

            local function flatten_symbols(symbols, parent_name)
                local flattened = {}
                for _, symbol in ipairs(symbols) do
                    local name = symbol.name
                    if parent_name then
                        name = parent_name .. "." .. name
                    end
                    table.insert(flattened, {
                        name = name,
                        kind = symbol.kind,
                        range = symbol.range,
                        selectionRange = symbol.selectionRange,
                    })
                    if symbol.children then
                        local children = flatten_symbols(symbol.children, name)
                        for _, child in ipairs(children) do
                            table.insert(flattened, child)
                        end
                    end
                end
                return flattened
            end

            local flat_symbols = flatten_symbols(result)

            -- Define highlight group for symbol kind
            vim.cmd([[highlight TelescopeSymbolKind guifg=#61AFEF]])

            require("telescope.pickers")
                .new({}, {
                    prompt_title = "Document Symbols: " .. vim.fn.fnamemodify(entry.path, ":t"),
                    finder = require("telescope.finders").new_table({
                        results = flat_symbols,
                        entry_maker = function(symbol)
                            local kind = vim.lsp.protocol.SymbolKind[symbol.kind] or "Other"
                            return {
                                value = symbol,
                                display = function(entry)
                                    local display_text = string.format("%-50s %s", entry.value.name, kind)
                                    return display_text,
                                        { { { #entry.value.name + 1, #display_text }, "TelescopeSymbolKind" } }
                                end,
                                ordinal = symbol.name,
                                filename = entry.path,
                                lnum = symbol.selectionRange.start.line + 1,
                                col = symbol.selectionRange.start.character + 1,
                            }
                        end,
                    }),
                    sorter = require("telescope.config").values.generic_sorter({}),
                    previewer = require("telescope.config").values.qflist_previewer({}),
                    attach_mappings = function(_, map)
                        map("i", "<CR>", function(prompt_bufnr)
                            local selection = action_state.get_selected_entry()
                            actions.close(prompt_bufnr)
                            vim.cmd("edit " .. selection.filename)
                            vim.api.nvim_win_set_cursor(0, { selection.lnum, selection.col - 1 })
                        end)
                        return true
                    end,
                })
                :find()
        end)
    end)
end

return M
