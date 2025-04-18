local M = {}

-- NOTE: return hostname of the machine
function M.get_hostname()
    local handle = io.popen("hostname")
    local hostname = handle:read("*a")
    handle:close()
    return hostname:match("^%s*(.-)%s*$")
end

-- NOTE: Normal mode keymaps
function M.keymap_normal(lhs, rhs, name, silent, desc)
    if desc then
        desc = name .. ": " .. desc
    end

    vim.keymap.set("n", lhs, rhs, {
        silent = silent,
        desc = desc,
    })
end

-- NOTE: Visual mode keymaps
function M.keymap_visual(lhs, rhs, name, silent, desc)
    if desc then
        desc = name .. ": " .. desc
    end

    vim.keymap.set("v", lhs, rhs, {
        silent = silent,
        desc = desc,
    })
end

-- NOTE: Generic keymap
function M.keymap(lhs, rhs, name, silent, desc)
    if desc then
        desc = name .. ": " .. desc
    end

    vim.keymap.set("", lhs, rhs, {
        silent = silent,
        desc = desc,
    })
end

-- NOTE: Silent keymap
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

-- NOTE: Loud keymap
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

-- NOTE: show information about a file
-- source: https://github.com/JoosepAlviste/dotfiles/tree/93f670c9b9d1972a8bc63f94698c4c0eec7c888a/config/nvim/lua/j/file_info
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

-- NOTE: Useful for WSL specific configuration
function M.is_wsl()
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

-- NOTE: Toggles line numbers
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

-- NOTE: Validate arguments before executing a function or callback, useful for
-- user created commands
function M.validate_args(fargs, min_args, usage_message)
    if #fargs < min_args then
        vim.notify(usage_message, vim.log.levels.WARN)
        return false
    end
    return true
end

-- NOTE: Clear quickfix list
function M.clear_quickfix()
    vim.fn.setqflist({})

    -- Close the quickfix window if it's open
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].buftype == "quickfix" then
            vim.api.nvim_win_close(win, true)
        end
    end

    vim.notify("Quickfix list cleared", vim.log.levels.INFO)
end

-- NOTE: Yank to registers
function M.yank_to_register(register)
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    local num_lines = end_line - start_line + 1

    vim.cmd('normal! "' .. register .. "y")

    vim.notify(
        string.format("Yanked %d line(s) to register '%s'", num_lines, register),
        vim.log.levels.INFO,
        { title = "Yank" }
    )
end

-- NOTE: Custom grep for word under cursor
function M.grep_word_under_cursor()
    local word = vim.fn.expand("<cword>") -- Get the word under the cursor
    if word ~= "" then
        vim.cmd("copen") -- Open quickfix list
        vim.cmd("silent grep " .. vim.fn.shellescape(word)) -- Perform grep safely
        vim.notify("Grep results for: " .. word, vim.log.levels.INFO) -- Display message
    else
        vim.notify("No word under the cursor to search for.", vim.log.levels.WARN)
    end
end

return M
