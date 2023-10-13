-- reload.lua
-- https://joseustra.com/blog/reloading-neovim-config-with-telescope/?source=ustrajunior.com

P = function(v)
    print(vim.inspect(v))
    return v
end

if pcall(require, "plenary") then
    RELOAD = require("plenary.reload").reload_module

    R = function(name)
        RELOAD(name)
        return require(name)
    end
end
