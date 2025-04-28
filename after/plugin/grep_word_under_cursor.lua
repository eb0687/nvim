-- NOTE: Custom grep for word under cursor

local function grep_word_under_cursor()
    local word = vim.fn.expand("<cword>") -- Get the word under the cursor
    if word ~= "" then
        vim.cmd("copen") -- Open quickfix list
        vim.cmd("silent grep " .. vim.fn.shellescape(word)) -- Perform grep safely
        vim.notify("Grep results for: " .. word, vim.log.levels.INFO) -- Display message
    else
        vim.notify("No word under the cursor to search for.", vim.log.levels.WARN)
    end
end

vim.api.nvim_create_user_command(
    "GrepCursorWord",
    grep_word_under_cursor,
    { desc = "Grep for the word under the cursor in cwd and open results in quickfix" }
)
