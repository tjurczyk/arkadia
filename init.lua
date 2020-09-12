scripts_loaded = scripts_loaded or false
local plugins_dir = getMudletHomeDir() .. "/plugins"

function load_scripts(force)
    if not force and scripts_loaded then
        return
    end

    if mudletOlderThan(4, 8) then
        cecho("\n\n<red>Zaktualizuj Mudlet. Skrypty moga nie dzialac poprawnie! Wymagana wersja 4.8+\n\n")
    end

    cecho("\n<CadetBlue>(skrypty)<tomato>: Laduje pliki skryptow\n")

    package.loaded.scriptsList = nil

    local mudlet_modules = require("scriptsList")
    raiseEvent("beforeLoadModules", mudlet_modules)

    for k, v in pairs(mudlet_modules) do
        package.loaded[v] = nil
        require(v)
    end

    append_plugins()

    scripts_loaded = true
    raiseEvent("scriptsLoaded")
end

function append_plugins()
    local path = package.path
    local homeDirectory = getMudletHomeDir():gsub("\\", "/") .. "/plugins/"

    local luaDirectory = string.format("%s/%s", homeDirectory, [[?.lua]])
    package.path = string.format("%s;%s", luaDirectory, path)

    if not io.exists(plugins_dir) then
        lfs.mkdir(plugins_dir)
    end

    scripts.plugins = {}

    for plugin_name in lfs.dir(plugins_dir) do
        load_plugin(plugin_name)
    end
end

function load_plugin(plugin_name)
    local file_path = plugins_dir .. '/' .. plugin_name
    if plugin_name ~= "." and plugin_name ~= ".." and lfs.attributes(file_path, 'mode') == 'directory' then
        local plugin_loaded = false
        if io.exists(file_path .. "/init.lua") then
            local plugin_modules = require(plugin_name .. ".init")
            for _, packages in pairs(plugin_modules) do
                local full_package_name = plugin_name .. "." .. packages
                package.loaded[full_package_name] = nil
                require(full_package_name)
            end
            plugin_loaded = true
        end
        local module_path = file_path .. "/" .. plugin_name .. ".xml"
        local is_git_repo = io.exists(file_path .. "/.git")
        if io.exists(module_path) and not is_git_repo then
            uninstallPackage(plugin_name)
            installPackage(module_path)
            plugin_loaded = true
        elseif io.exists(module_path) and is_git_repo then
            if not pcall(getModulePriority, plugin_name) then
                installModule(module_path)
                enableModuleSync(plugin_name)
                setModulePriority(plugin_name, getModulePriority("Arkadia") + table.size(scripts.plugins))
            end
            plugin_loaded = true
        end
        if plugin_loaded then
            table.insert(scripts.plugins, plugin_name)
            cecho("\n<CadetBlue>(skrypty)<tomato>: Plugin " .. plugin_name .. " zaladowany\n")
        else
            cecho("\n<CadetBlue>(skrypty)<tomato>: Plugin " .. plugin_name .. " nie zostal zaladowany. Brak pliku init.lua lub " .. plugin_name .."\n")
        end
    end
end

function reload_single_script(path)
    package.loaded[path] = nil
    local ok, errorMsg = pcall(require, path)
    if ok then
        scripts:print_log("Przeladowano paczki '" .. path .. "'")
    else
        scripts:print_log("Nie udalo sie przeladowac paczki '" .. path .. "'. Sprawdz log bledow")
        error(errorMsg)
    end
end

function alias_func_reload()
    if matches[2] == "" then
        package.loaded.init = nil
        require("init")
        load_scripts(true)
        if scripts.config then
            scripts.config:load_config(true)
        end
    else
        reload_single_script(matches[2])
    end
end

load_scripts(false)
