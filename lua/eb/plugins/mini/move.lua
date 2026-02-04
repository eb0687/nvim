-- MINI MOVE
local M = {}

function M.setup()
    local move = require("mini.move")
    move.setup({
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
            -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
            left = "<",
            right = ">",
            down = "J",
            up = "K",

            -- Move current line in Normal mode
            line_left = "<M-Left>",
            line_right = "<M-Right>",
            line_down = "<M-Down>",
            line_up = "<M-Up>",
        },

        -- Options which control moving behavior
        options = {
            -- Automatically reindent selection during linewise vertical move
            reindent_linewise = true,
        },
    })
end

return M
