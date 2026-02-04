-- MINI STATUSLINE
local M = {}

function M.setup()
    local statusline = require("mini.statusline")

    statusline.setup({
        use_icons = true,
        content = {
            active = function()
                local mode, mode_hl = statusline.section_mode({ trunc_width = 1000 })
                local lsp = statusline.section_lsp({ trunc_width = 100 })
                local location = statusline.section_location({ trunc_width = 1000 })
                local word_count = require("eb.utils.mini-helpers.word-count")
                local words = word_count.filetype() and word_count.word_count(100) or ""
                local diff = require("eb.utils.mini-helpers.git-diff").diff_source(100)
                local buffer_count = require("eb.utils.mini-helpers.buffer-count").count_buffers(100)
                local diagnostics = require("eb.utils.mini-helpers.diagnostics").status(100)
                local filename = require("eb.utils.mini-helpers.filename").format_filename()
                local git = require("eb.utils.mini-helpers.git").branch_name()
                local macro = require("eb.utils.mini-helpers.macro").status()
                local permissions = require("eb.utils.mini-helpers.permissions").get_permissions()
                local qf = require("eb.utils.mini-helpers.quickfix").counter()
                local lazy_status = require("lazy.status")
                local lazy = statusline.is_truncated(100) and ""
                    or (lazy_status.has_updates() and (lazy_status.updates()) or "")

                return statusline.combine_groups({
                    { hl = mode_hl, strings = { mode } },
                    { hl = "MiniStatuslineGit", strings = { git } },
                    {
                        hl = (vim.bo.readonly or not vim.bo.modifiable) and "MiniStatuslineFilenameReadonly"
                            or (vim.bo.modified and "MiniStatuslineFilenameModified")
                            or "MiniStatuslineFilename",
                        strings = { filename },
                    },
                    { strings = { diff } },
                    { strings = { diagnostics } },
                    { strings = { permissions } },
                    { strings = { "%=" } },
                    { strings = { words } },
                    { strings = { "%=" } },
                    { strings = { qf } },
                    { hl = "MiniStatusLineLazy", strings = { lazy } },
                    { strings = { buffer_count } },
                    { hl = "MiniStatuslineLocation", strings = { location } },
                    { hl = "MiniStatuslineLsp", strings = { lsp } },
                    { hl = "MiniStatuslineMacro", strings = { macro } },
                })
            end,
        },
    })
end

return M
