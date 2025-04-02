-- https://github.com/dmmulroy/kickstart.nix/blob/main/config/nvim/lua/user/edit_text.lua

-- Function to set options for a specific filetype
local function set_opts()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt.spelllang = { "en_us" }
    vim.opt_local.conceallevel = 2
end

-- Create an autocmd group to avoid duplication
local edit_opts = vim.api.nvim_create_augroup("edit_text", { clear = true })

-- Set filetypes here
local patterns = { "gitcommit", "markdown", "text", "NeogitCommitMessage" }

-- Function to enable cmp-spell source
-- local function enable_cmp_spell_source()
--     local cmp = require("cmp")
--     cmp.setup.buffer({
--         sources = {
--             { name = "luasnip" },
--             { name = "spell" },
--             { name = "buffer" },
--             { name = "nvim_lsp" },
--             { name = "path" },
--             { name = "gitmoji" },
--             { name = "codeium" },
--             { name = "copilot" },
--         },
--     })
-- end

-- vim.api.nvim_create_autocmd({ "FileType" }, {
--     group = edit_opts,
--     pattern = patterns,
--     desc = "Enable spell checking and text wrapping for certain filetypes",
--     callback = function()
--         set_opts()
--         enable_cmp_spell_source()
--     end,
-- })
