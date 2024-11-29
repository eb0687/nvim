local M = {}

-- return hostname of the machine
function M.get_hostname()
    local handle = io.popen("hostname")
    local hostname = handle:read("*a")
    handle:close()
    return hostname:match("^%s*(.-)%s*$")

    -- local handle = io.popen("hostname")
    -- if not handle then
    --     return nil
    -- end
    -- local hostname = handle:read("*a")
    -- handle:close()
    -- if not hostname then
    --     return nil
    -- end
    -- return hostname
end

-- function for normal mode keymaps
function M.keymap_normal(lhs, rhs, name, silent, desc)
    if desc then
        desc = name .. ": " .. desc
    end

    vim.keymap.set("n", lhs, rhs, {
        silent = silent,
        desc = desc,
    })
end

-- function for visual mode keymaps
function M.keymap_visual(lhs, rhs, name, silent, desc)
    if desc then
        desc = name .. ": " .. desc
    end

    vim.keymap.set("v", lhs, rhs, {
        silent = silent,
        desc = desc,
    })
end

function M.keymap(lhs, rhs, name, silent, desc)
    if desc then
        desc = name .. ": " .. desc
    end

    vim.keymap.set("", lhs, rhs, {
        silent = silent,
        desc = desc,
    })
end

function M.keymap_silent(mode, keys, func, desc)
    if desc then
        desc = "CUSTOM: " .. desc
    end
    vim.keymap.set(mode, keys, func, {
        noremap = true,
        silent = true,
        desc = desc,
    })
end

function M.keymap_loud(mode, keys, func, desc)
    if desc then
        desc = "CUSTOM: " .. desc
    end
    vim.keymap.set(mode, keys, func, {
        noremap = true,
        silent = false,
        desc = desc,
    })
end

-- SOURCE: https://github.com/JoosepAlviste/dotfiles/tree/93f670c9b9d1972a8bc63f94698c4c0eec7c888a/config/nvim/lua/j/file_info
function M.file_info()
    local filename = vim.fn.expand("%"):gsub(vim.pesc(vim.loop.cwd()), "."):gsub(vim.pesc(vim.fn.expand("$HOME")), "~")

    local type = vim.bo.ft
    local branch = vim.b.gitsigns_head
    local lsp_client_names = table.concat(
        vim.tbl_map(function(client)
            return client.name
        end, vim.tbl_values(vim.lsp.buf_get_clients(0))),
        ", "
    )

    -- Each line consists of a label and a text.
    local lines = { { "name", filename } }
    if #type > 1 then
        table.insert(lines, { "type", type })
    end
    if branch then
        table.insert(lines, { "branch", branch })
    end
    if #lsp_client_names > 1 then
        table.insert(lines, { "lsp", lsp_client_names })
    end

    local label_lengths = vim.tbl_map(function(line)
        return #line[1]
    end, lines)
    local max_label_length = math.max(unpack(label_lengths))

    -- Pad labels of lines and convert each line to a string
    local lines_texts = vim.tbl_map(function(line)
        local label = line[1]
        local text = line[2]

        local padding = ""
        local nr_of_spaces_to_add = max_label_length - #label
        for i = 1, nr_of_spaces_to_add do
            padding = padding .. " "
        end

        return label .. ": " .. padding .. text
    end, lines)

    vim.notify(table.concat(lines_texts, "\n"), vim.log.levels.INFO, {
        title = " File info",
    })
end

local function is_wsl()
    local handle = io.popen("grep -qi microsoft /proc/version && echo true || echo false")
    local result = handle:read("*a")
    handle:close()
    return result:match("^%s*(.-)%s*$") == "true"
end

-- NOTE: this uses wslview to open links in windows default browser
function M.open_in_browser()
    local file = vim.fn.expand("<cfile>")
    local escaped_file = vim.fn.shellescape(file) -- Escape the file for safe use in shell commands
    if is_wsl() then
        vim.fn.system("wslview " .. escaped_file)
    else
        vim.fn.system("xdg-open " .. escaped_file)
    end
end

-- NOTE: toggles line numbers
-- source: https://github.com/pwnwriter/pwnvim/blob/main/lua/modules.lua#L3
local cmds = { "nu!", "rnu!", "nonu!" }
local current_index = 1

function M.toggle_numbering()
    current_index = current_index % #cmds + 1
    vim.cmd("set " .. cmds[current_index])
    local signcolumn_setting = "auto"
    if cmds[current_index] == "nonu!" then
        signcolumn_setting = "yes:4"
    end
    vim.opt.signcolumn = signcolumn_setting
end

-- NOTE: Toggle inlay hints
function M.toggle_inlay_hint()
    local is_enabled = vim.lsp.inlay_hint.is_enabled()
    vim.lsp.inlay_hint.enable(not is_enabled)
end

-- NOTE: Toggle flow
local state = 0
function M.toggle_flow()
    if state == 0 then
        vim.o.relativenumber = false
        vim.o.number = false
        vim.opt.signcolumn = "no"
        vim.opt.laststatus = 1
        state = 1
        vim.cmd("redraw")
    else
        vim.o.relativenumber = true
        vim.o.number = true
        vim.opt.signcolumn = "auto"
        vim.opt.laststatus = 2
        state = 0
        vim.cmd("redraw")
    end
end

return M
