scriptsLoaded = scriptsLoaded or false

function loadScripts(force)
    if not force and scriptsLoaded then
        return
    end

    cecho("\n<CadetBlue>(skrypty)<tomato>: Laduje pliki skryptow\n")

    mudletModules = {}
    package.loaded.scriptsList = nil
    require("scriptsList")

    for k, v in pairs(mudletModules) do
        package.loaded[v] = nil
        require(v)
    end

    scriptsLoaded = true
end

function reloadScripts()
    package.loaded.init = nil
    require("init")
    loadScripts(true)
end

function reloadSingleScript(path)

    package.loaded[path] = nil
    local ok, errorMsg = pcall(require, path)
    if ok then
        scripts:print_log("Przeladowano paczki '" .. path .. "'")
    else
        scripts:print_log("Nie udalo sie przeladowac paczki '" .. path .. ". ' Sprawdz log bledow")
        error(errorMsg)
    end
end

function alias_func_reload()
    if matches[2] == "" then
        loadScripts(true)
    else
        reloadSingleScript(matches[2])
    end
end

loadScripts(false)
