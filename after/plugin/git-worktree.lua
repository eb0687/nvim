-- git-worktree
-- https://github.com/ThePrimeagen/git-worktree.nvim
-- BUG: there is an error with the telescope integration, details & fix in this link:
-- https://github.com/ThePrimeagen/git-worktree.nvim/issues/97#issuecomment-1248246825

-- SETUP [[[
require("git-worktree").setup({
    -- NOTE: Set this to 'tcd' if you want to only change the pwd for the current vim Tab
    change_directory_command = 'cd', -- default: "cd",
    -- NOTE: Updates the current buffer to point to the new work tree if the file is found in the new project. Otherwise, the following command will be run
    update_on_change = true, -- default: true,
    -- NOTE: The vim command to run during the update_on_change event. Note, that this command will only be run when the current file is not found in the new worktree. This option defaults to e . which opens the root directory of the new worktree.
    update_on_change_command = 'e .', -- default: "e .",
    -- NOTE: Every time you switch branches, your jumplist will be cleared so that you don't accidentally go backward to a different branch and edit the wrong files.
    clearjumps_on_change = true, -- default: true,
    -- NOTE: When creating a new worktree, it will push the branch to the upstream then perform a git rebase
    autopush = false -- default: false,
})

-- Telescope plugin integration
require("telescope").load_extension("git_worktree")

-- ]]]
-- KEYMAP [[[

local keymap = function(keys, func, desc)
    if desc then
        desc = 'Git-Worktree: ' .. desc
    end

    vim.keymap.set('n', keys, func, { desc = desc })
end

-- Bindings
keymap('<leader>gw', ":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", 'Switch & Delete worktree')
keymap('<leader>gc', ":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", 'Create a worktree')

-- ]]]
-- HOOKS [[[

local Worktree = require("git-worktree")

-- SOURCE: https://github.com/ThePrimeagen/git-worktree.nvim#hooks
-- op = Operations.Switch, Operations.Create, Operations.Delete
-- metadata = table of useful values (structure dependent on op)
--      Switch
--          path = path you switched to
--          prev_path = previous worktree path
--      Create
--          path = path where worktree created
--          branch = branch name
--          upstream = upstream remote name
--      Delete
--          path = path where worktree deleted

Worktree.on_tree_change(function(op, metadata)
  if op == Worktree.Operations.Switch then
    print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
  end
end)

-- ]]]

-- TEST:
-- print("Hello from AFTER/GIT-WORKTREE")
