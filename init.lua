scripts_loaded = scripts_loaded or false

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
    append_plugins(mudlet_modules)
    raiseEvent("beforeLoadModules", mudlet_modules)

    for k, v in pairs(mudlet_modules) do
        package.loaded[v] = nil
        require(v)
    end

    scripts_loaded = true
    raiseEvent("scriptsLoaded")
end

function append_plugins(mudlet_modules)
    local path = package.path
    local homeDirectory = getMudletHomeDir():gsub("\\", "/") .. "/plugins/"

    local luaDirectory = string.format("%s/%s", homeDirectory, [[?.lua]])
    package.path = string.format("%s;%s", luaDirectory, path)



    local plugins_dir = getMudletHomeDir() .. "/plugins"
    if not io.exists(plugins_dir) then
        lfs.mkdir(plugins_dir)
    end

    local valid_plugins = {}

    for module_name in lfs.dir(plugins_dir) do
        local file_path = plugins_dir .. '/' .. module_name
        if module_name ~= "." and module_name ~= ".." and lfs.attributes(file_path, 'mode') == 'directory' then
            if io.exists(file_path .. "/init.lua") then
                table.insert(valid_plugins, module_name)
            end
            local modulePath = file_path .. "/" .. module_name .. ".xml"
            if io.exists(modulePath) then
                uninstallPackage(module_name)
                installPackage(modulePath)
            end
        end
    end

    for _, plugin_name in pairs(valid_plugins) do
        local plugin_modules = require(plugin_name .. ".init")
        for _, packages in pairs(plugin_modules) do
            table.insert(mudlet_modules, plugin_name .. "." .. packages)
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
        scripts.config_loader:reload_last_config()
    else
        reload_single_script(matches[2])
    end
end

load_scripts(false)
