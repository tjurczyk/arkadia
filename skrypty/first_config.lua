scripts.first_time_config = scripts.first_time_config or {
    numpad_just_installed = false,
}

function scripts.first_time_config:init()

    uninstallPackage("generic_mapper")
    map.eventHandler = function () end

    self.window = PageWindow:new("first_config", "Arkadia Skrypty - wstepna konfiguracja", false, false, "f")

    self.window:addPage(scripts.first_time_config.base_and_map)
    self.window:addPage(scripts.first_time_config.plugins)
    
    self.window:open()

    registerAnonymousEventHandler("loginSuccessful", function() self.window:reloadPage() end, true)
    registerAnonymousEventHandler("sysDownloadDone", function() tempTimer(0.5, function() self.window:reloadPage() end) end, true)
end

function scripts.first_time_config.base_and_map(windowPage, index)
    cecho(windowPage.name, "Wstepna konfiguracja skryptow\n")
    cecho(windowPage.name, "-------------------\n")
    cecho(windowPage.name, "Ponizej znajduje sie kilka podstawowych opcji konfiguracyjnych. Po zamknieciu tego okna, nie pojawi sie ono wiecej, chyba, ze wpiszesz <tomato>/konfiguracja<reset>")
    cecho(windowPage.name, "\n\n")
    cecho(windowPage.name, "Konfiguracja postaci\n")
    cecho(windowPage.name, "-------------------\n")
    if not scripts.config then
        cecho(windowPage.name, "<red>X<reset> Nie masz utworzonej/zaladowanej konfiguracji postaci.\n")
        if gmcp.char and gmcp.char.info and gmcp.char.info.name and amap.logged_name then
            local create_config_code = string.format([[scripts_init_v2_config("%s", "%s") scripts.first_time_config.window:reloadPage()]], string.proper_case(gmcp.char.info.name), amap.logged_name)
            cechoLink(windowPage.name, string.format("Wpisz <tomato>/cinit %s %s<reset> lub kliknij <light_slate_blue>tutaj<reset>", string.proper_case(gmcp.char.info.name), amap.logged_name), create_config_code, "Tworzenie konfiguracji", true)
        else
            cechoLink(windowPage.name, "Nie moge wykryc imienia do konfiguracj. Kliknij <light_slate_blue>tutaj<reset>, zeby polaczyc sie z Arkadia", [[connectToServer("arkadia.rpg.pl", 23, false)]], "Laczenie sie z Arkadia", true)
        end
    else
        cecho(windowPage.name, "<green>✓<reset> Masz zaladowana konfiguracje postaci.")
    end
    cecho(windowPage.name, "\n\n")
    cecho(windowPage.name, "Baza danych postaci\n")
    cecho(windowPage.name, "-------------------\n")
    if #db:fetch(scripts.people.db.people) == 0 then
        cecho(windowPage.name, "<red>X<reset> Nie masz pobranej bazy postaci.\n")
        cechoLink(windowPage.name, "Wpisz <tomato>/pobierz_baze<reset> lub kliknij <light_slate_blue>tutaj<reset>", [[alias_func_skrypty_installer_download_people_db()]], "Pobieranie bazy", true)
    else
        cecho(windowPage.name, "<green>✓<reset> Masz juz pobrana baze postaci.")
    end
    cecho(windowPage.name, "\n\n")
    cecho(windowPage.name, "Mapa\n")
    cecho(windowPage.name, "-------------------\n")
    if not io.exists(getMudletHomeDir() .. "/map_master3.dat") then
        cecho(windowPage.name, "<red>X<reset> Nie masz pobranej mapy.\n")
        cechoLink(windowPage.name, "Wpisz <tomato>/pobierz_mape<reset> lub kliknij <light_slate_blue>tutaj<reset>", [[alias_func_skrypty_installer_download_map()]], "Pobieranie mapy", true)
    else
    
        cecho(windowPage.name, "<green>✓<reset> Masz juz pobrana mape.")
        amap:locate(true)
    end
    cecho(windowPage.name, "\n\n")
    cecho(windowPage.name, "Poruszanie sie\n")
    cecho(windowPage.name, "-------------------\n")
    if not self.numpad_just_installed then
        cechoLink(windowPage.name, "- <light_slate_blue>Zainstaluj<reset> poruszanie sie klawiatura numeryczna<reset>", [[installPackage(getMudletHomeDir() .. "/arkadia/packages/numpad_keys.xml") scripts.first_time_config.numpad_just_installed = true]], "Instalacja poruszania sie klawiatura numeryczna", true)
    else 
        cecho("<green>✓<reset>Poruszanie sie klawiatura numeryczna zainstalowane.)
    end
    echo(windowPage.name, "\n")
    cechoLink(windowPage.name, "- <light_slate_blue>Zainstaluj<reset> poruszanie sie ctrl+alt+uiojklnm,<reset>", [[alias_func_skrypty_installer_download_map()]], "Instalacja poruszania sie bez klawiatury numerycznej", true)
end

function scripts.first_time_config.plugins(windowPage, index)
    cecho(windowPage.name, "Polecane wtyczki do skryptow:")
    echo(windowPage.name, "\n\n\n")
    cecho(windowPage.name, "Mudlet Map Reader\n")
    cecho(windowPage.name, "-----------------\n")
    cechoLink(windowPage.name, "Opis: <light_slate_blue>https://github.com/Delwing/mudlet-map-reader<reset>\n", [[openUrl("https://github.com/Delwing/mudlet-map-reader")]], "", true)
    cechoLink(windowPage.name, "Zainstaluj: <light_slate_blue>kliknij<reset>\n", [[scripts.plugins_installer.install_from_url(scripts.plugins_installer, "https://codeload.github.com/Delwing/mudlet-map-reader/zip/master")]], "", true)
    echo(windowPage.name, "\n\n")
    cecho(windowPage.name, "Arkadia Config Editor\n")
    cecho(windowPage.name, "-----------------\n")
    cechoLink(windowPage.name, "Opis: <light_slate_blue>https://github.com/Delwing/arkadia-cfg-editor<reset>\n", [[openUrl("https://github.com/Delwing/arkadia-cfg-editor)]], "", true)
    cechoLink(windowPage.name, "Zainstaluj: <light_slate_blue>kliknj<reset>", [[scripts.plugins_installer.install_from_url(scripts.plugins_installer, "https://codeload.github.com/Delwing/arkadia-cfg-editor/zip/master")]], "", true)
end

scripts.first_time_config:init()
