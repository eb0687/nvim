-- MINI AI
-- SOURCE: https://github.com/echasnovski/mini.ai?tab=readme-ov-file

local M = {}

function M.setup()
    local gen_ai_spec = require("mini.extra").gen_ai_spec
    local ai = require("mini.ai")
    ai.setup({
        custom_textobjects = {
            B = gen_ai_spec.buffer(),
            D = gen_ai_spec.diagnostic(),
            I = gen_ai_spec.indent(),
            L = gen_ai_spec.line(),
            N = gen_ai_spec.number(),
        },
    })
end

return M
