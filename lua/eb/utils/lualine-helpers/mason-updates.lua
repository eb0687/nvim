local M = {}

-- check for mason package upgrades
-- https://github.com/williamboman/mason.nvim/discussions/1535
function M.get_updates()
    local registry = require("mason-registry")
    local installed_packages = registry.get_installed_package_names()
    local upgrades_available = false
    local packages_outdated = 0
    local function myCallback(success, result_or_err)
        if success then
            upgrades_available = true
            packages_outdated = packages_outdated + 1
        end
    end

    for _, pkg in pairs(installed_packages) do
        local p = registry.get_package(pkg)
        if p then
            p:check_new_version(myCallback)
        end
    end

    if upgrades_available then
        return packages_outdated
    else
        return ""
    end
end

return M
