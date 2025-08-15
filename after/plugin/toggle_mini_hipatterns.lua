-- NOTE: Toggle MiniHiPattern usercommand
local MiniHipatterns = require("mini.hipatterns")
vim.api.nvim_create_user_command("ToggleMiniHipatterns", function()
    MiniHipatterns.toggle()
end, { desc = "Toggle MiniHipatterns" })
