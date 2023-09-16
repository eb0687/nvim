--                                            _
--    ___ ___  _ __ ___  _ __ ___   ___ _ __ | |_ __ _ _ __ _   _
--   / __/ _ \| '_ ` _ \| '_ ` _ \ / _ \ '_ \| __/ _` | '__| | | |
--  | (_| (_) | | | | | | | | | | |  __/ | | | || (_| | |  | |_| |
--   \___\___/|_| |_| |_|_| |_| |_|\___|_| |_|\__\__,_|_|   \__, |
--                                                          |___/
-- https://github.com/tpope/vim-commentary

return {
    'tpope/vim-commentary',

    -- refer to this video for exaplanation on the below events:
    -- https://youtu.be/6mxWayq-s9I
    event = { 'BufReadPre', 'BufNewFile' },

    config = function()
        local keymap_n = function(keys, func, desc)
            if desc then
                desc = 'VIM-Commentary: ' .. desc
            end

            vim.keymap.set('n', keys, func, { desc = desc })
        end

        local keymap_v = function(keys, func, desc)
            if desc then
                desc = 'VIM-Commentary: ' .. desc
            end

            vim.keymap.set('v', keys, func, { desc = desc })
        end

        -- KEYMAPS
        keymap_n("<C-q>", ":Commentary<CR>", 'Add a comment in normal mode')
        keymap_v("<C-q>", ":Commentary<CR>", 'Add a comment in visual mode')

        -- TEST:
        -- print("Hello from lazy commentary")
    end
}
