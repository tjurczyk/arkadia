scripts.first_time_config = scripts.first_time_config or {}

function scripts.first_time_config:init()
    local firsTimeConfig = PageWindow:new("first_config", "Arkadia Skrypty - wstepna konfiguracja", false, false, "f")

    firsTimeConfig:addPage(scripts.first_time_config.base_and_map)
    firsTimeConfig:addPage(scripts.first_time_config.plugins)
    firsTimeConfig:open()
end

function scripts.first_time_config.base_and_map(windowPage, index)
    cecho(windowPage.name, "Konfiguracja postaci\n")
    cecho(windowPage.name, "-------------------\n")
    if scripts.config then
        cecho(windowPage.name, "<red>X<reset> Nie masz utworzonej/zaladowanej konfiguracji postaci.\n")
        cechoLink(windowPage.name, "Wpisz <tomato>/cinit imie imie_w_wolaczu<reset> lub kliknij <light_slate_blue>tutaj<reset>", [[(/cinit)]], "Tworzenie konfiguracji", true)
    else
        cecho(windowPage.name, "<green>✓<reset> Masz zaladowana konfiguracje postaci.")
    end
    cecho(windowPage.name, "\n\n")
    cecho(windowPage.name, "Baza danych postaci\n")
    cecho(windowPage.name, "-------------------\n")
    if io.exists(getMudletHomeDir() .. "/Database_people.db") then
        cecho(windowPage.name, "<red>X<reset> Nie masz pobranej bazy postaci.\n")
        cechoLink(windowPage.name, "Wpisz <tomato>/pobierz_baze<reset> lub kliknij <light_slate_blue>tutaj<reset>", [[alias_func_skrypty_installer_download_people_db()]], "Pobieranie bazy", true)
    else
        cecho(windowPage.name, "<green>✓<reset> Masz juz pobrana baze postaci.")
    end
    cecho(windowPage.name, "\n\n")
    cecho(windowPage.name, "Mapa\n")
    cecho(windowPage.name, "-------------------\n")
    if io.exists(getMudletHomeDir() .. "/map_master3.dat") then
        cecho(windowPage.name, "<red>X<reset> Nie masz pobranej mapy.\n")
        cechoLink(windowPage.name, "Wpisz <tomato>/pobierz_mape<reset> lub kliknij <light_slate_blue>tutaj<reset>", [[alias_func_skrypty_installer_download_map()]], "Pobieranie mapy", true)
    else
    
        cecho(windowPage.name, "<green>✓<reset> Masz juz pobrana mape.")
        amap:locate(true)
    end
    cecho(windowPage.name, "\n\n")
    cecho(windowPage.name, "Poruszanie sie\n")
    cecho(windowPage.name, "-------------------\n")
    cechoLink(windowPage.name, "- <light_slate_blue>Zainstaluj<reset> poruszanie sie klawiatura numeryczna<reset>", [[alias_func_skrypty_installer_download_map()]], "Instalacja poruszania sie klawiatura numeryczna", true)
    echo(windowPage.name, "\n")
    cechoLink(windowPage.name, "- <light_slate_blue>Zainstaluj<reset> poruszanie sie ctrl+alt+uiojklnm,<reset>", [[alias_func_skrypty_installer_download_map()]], "Instalacja poruszania sie bez klawiatury numerycznej", true)
end

function scripts.first_time_config.plugins(windowPage, index)
    cecho(windowPage.name, "Polecane wtyczki do skryptow:")
    echo(windowPage.name, "\n\n\n")
    cecho(windowPage.name, "Mudlet Map Reader\n")
    cecho(windowPage.name, "-----------------\n")
    cechoLink(windowPage.name, "Opis: <light_slate_blue>https://github.com/Delwing/mudlet-map-reader<reset>\n", [[openUrl("https://github.com/Delwing/mudlet-map-reader")]], "", true)
    cecho("\n")
    cechoLink(windowPage.name, "Zainstaluj: <light_slate_blue>kliknij<reset>\n", [[scripts.plugins_installer.install_from_url(scripts.plugins_installer, "https://codeload.github.com/Delwing/mudlet-map-reader/zip/master")]], "", true)
    cecho("\n")
    cecho("\n")
    cecho(windowPage.name, "Arkadia Config Editor\n")
    cecho(windowPage.name, "-----------------\n")
    cechoLink(windowPage.name, "Opis: <light_slate_blue>https://github.com/Delwing/arkadia-cfg-editor<reset>", [[openUrl("https://github.com/Delwing/arkadia-cfg-editor)]], "", true)
    cechoLink(windowPage.name, "Zainstaluj: <light_slate_blue>kliknji<reset>", [[scripts.plugins_installer.install_from_url(scripts.plugins_installer, "https://codeload.github.com/Delwing/arkadia-cfg-editor/zip/master")]], "", true)
end

scripts.first_time_config:init()
