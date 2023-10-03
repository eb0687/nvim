--      _           _ _               _
--   __| | __ _  __| | |__   ___   __| |
--  / _` |/ _` |/ _` | '_ \ / _ \ / _` |
-- | (_| | (_| | (_| | |_) | (_) | (_| |
--  \__,_|\__,_|\__,_|_.__/ \___/ \__,_|
-- https://github.com/tpope/vim-dadbod
-- https://github.com/kristijanhusak/vim-dadbod-ui
-- https://github.com/kristijanhusak/vim-dadbod-completion

return {
    'tpope/vim-dadbod',
    'kristijanhusak/vim-dadbod-ui',
    'kristijanhusak/vim-dadbod-completion',
    config = function()
        require('config.dadbod').setup()
        require('cmp').setup.buffer({
            sources = {{
                name = 'vim-dadbod-completion'
            }}
        })
    end,
}
