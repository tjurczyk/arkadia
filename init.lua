scripts_loaded = scripts_loaded or false

function load_scripts(force)
    if not force and scripts_loaded then
        return
    end

    if mudletOlderThan(4, 8) then
        cecho("\n\n<red>Zaktualizuj Mudlet. Skrypty moga nie dzialac poprawnie! Wymagana wersja 4.8+\n\n")
    end

    cecho("\n<CadetBlue>(skrypty)<tomato>: Laduje pliki skryptow\n")

    mudletModules = {}
    package.loaded.scriptsList = nil
    require("scriptsList")

    for k, v in pairs(mudletModules) do
        package.loaded[v] = nil
        require(v)
    end

    scripts_loaded = true
    raiseEvent("scriptsLoaded")
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
