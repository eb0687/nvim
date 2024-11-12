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

return M
