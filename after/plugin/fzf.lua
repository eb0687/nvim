--   __     __       _
--  / _|___/ _|     | |_   _  __ _
-- | ||_  / |_ _____| | | | |/ _` |
-- |  _/ /|  _|_____| | |_| | (_| |
-- |_|/___|_|       |_|\__,_|\__,_|

-- protective call so nothing breaks if fzf-lua is missing
local status_ok, _ = pcall(require, "fzf-lua")
if not status_ok then
  return
end

-- setup (WIP)
require('fzf-lua').setup({
    files = {
        prompt = ' Files: ',
        winopts = {
            height = 1.0,
            width = 1.0,
            preview = {
                hidden = 'hidden',
                horizontal = 'right:50%'
            }
        },
    }
})
