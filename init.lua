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

if not exists("reload scripts", "alias") then
    permAlias("reload scripts", "Arkadia", "^/reload$", "reloadScripts()")
end

loadScripts(false)
