-- MINI HI-PATTERNS
-- SOURCE: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-hipatterns.md
-- NOTE: look at the examples for custom setup similar to todo-comments

local M = {}

function M.setup()
    local extra = require("mini.extra")
    local hipatterns = require("mini.hipatterns")
    -- local hi_words = extra.gen_highlighter.words
    hipatterns.setup({
        highlighters = {
            todo = { pattern = "%f[%w]()TODO:.*", group = "MiniHipatternsTodo" },
            fixme = { pattern = "%f[%w]()FIXME:.*", group = "MiniHipatternsFixme" },
            test = { pattern = "%f[%w]()TEST:.*", group = "MiniHipatternsHack" },
            note = { pattern = "%f[%w]()NOTE:.*", group = "MiniHipatternsNote" },
            info = { pattern = "%f[%w]()INFO:.*", group = "MiniHipatternsNote" },
            source = { pattern = "%f[%w]()SOURCE:", group = "MiniHipatternsNote" },
            small_source = { pattern = "%f[%w]()source:", group = "MiniHipatternsNote" },
            -- note = hi_words({ "NOTE", "INFO" }, "MiniHipatternsNote"),
            -- source = hi_words({ "SOURCE", "source" }, "MiniHipatternsNote"),

            hex_color = hipatterns.gen_highlighter.hex_color(),
        },
    })
end

return M
