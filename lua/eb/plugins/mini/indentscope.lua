-- MINI INDENTSCOPE
local M = {}

function M.setup()
    local indent = require("mini.indentscope")
    indent.setup({
        -- symbol = "▎",
        symbol = "│ ",
        draw = {
            animation = indent.gen_animation.none(),
        },
    })
end

return M
