-- NOTE: https://github.com/neovim/neovim/pull/15959
-- TESTING:
local user_command = vim.api.nvim_create_user_command
local input = vim.ui.input

local user_prompt = function()
    input({
            prompt = 'Please enter some information: ',
            default = 'this is a test'
        },
        function(result)
            vim.notify(result)
        end)
end

user_command('HelloWorld', user_prompt, {
    desc = 'this a hello world user command test'
})
