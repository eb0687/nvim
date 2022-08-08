--      __
--     / /_  ____  ____
--    / __ \/ __ \/ __ \
--   / / / / /_/ / /_/ /
--  /_/ /_/\____/ .___/
--             /_/

-- protective call so nothing breaks if hop is missing
local status_ok, _ = pcall(require, "hop")
if not status_ok then
  return
end

require('hop').setup({
    keys = 'etovxqpdygfblzhckisuran',
    jump_on_sole_occurrence = true,
})
