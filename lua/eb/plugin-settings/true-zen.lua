-- protective call so nothing breaks if true-zen is missing
local status_ok, _ = pcall(require, "true-zen")
if not status_ok then
  return
end

require('true-zen').setup{}
