--        _                 _           _         _
-- __   _(_)_ __ ___       | | __ _ ___| |_ _ __ | | __ _  ___ ___
-- \ \ / / | '_ ` _ \ _____| |/ _` / __| __| '_ \| |/ _` |/ __/ _
--  \ V /| | | | | | |_____| | (_| \__ \ |_| |_) | | (_| | (_|  __/
--   \_/ |_|_| |_| |_|     |_|\__,_|___/\__| .__/|_|\__,_|\___\___|
--                                         |_|
-- https://github.com/farmergreg/vim-lastplace

return {
    'farmergreg/vim-lastplace',
    config = function()
        local global_var = vim.g

        global_var.lastplace_open_folds = 0
        global_var.lastplace_ignore_buftype = 'quickfix, nofile, help'
        global_var.lastplace_ignore = 'gitcommit, gitrebase, svn, hgcommit'
    end
}
