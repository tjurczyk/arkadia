scripts.first_time_config = scripts.first_time_config or {
    package_installed = {}
}

function scripts.first_time_config:show_hint()
    if scripts.first_time_config:is_first_run() then
        cecho("\n<yellow>==============================================================================================")
        echo("\n\n")
        cecho("<yellow>    Wyglada na to, ze to twoje pierwsze uruchomienie skryptow.\n")
        cecho("<yellow>    Jezeli tak nie jest, zignoruj ta wiadomosc, nie pojawi sie ona wiecej.\n")
        local init_code = [[alias_func_first_time_config()]]
        cechoLink("<yellow>    Kliknij <light_slate_blue>tutaj<yellow> aby uruchomic konfigurator.", init_code, "Uruchom konfigurator", true)
        cecho("\n\n<yellow>==============================================================================================\n\n")
    end
end

function scripts.first_time_config:is_first_run()
    return not (io.exists(getMudletHomeDir() .. "/map_master3.dat") or #db:fetch(scripts.people.db.people) == 0)
end

function scripts.first_time_config:init()
    if not self.window then
        uninstallPackage("generic_mapper")
        if map then
            map.eventHandler = function () end
        end

        self.config_window = PageWindow:new("first_config", "Arkadia Skrypty - wstepna konfiguracja", false, false, "f")

        self.config_window:add_page(scripts.first_time_config.base_and_map)
        self.config_window:add_page(scripts.first_time_config.plugins)

        registerAnonymousEventHandler("loginSuccessful", function() self.config_window:reload_page() end, true)
        registerAnonymousEventHandler("sysInstall", function() tempTimer(1, function() self.config_window:reload_page() end) end)
        registerAnonymousEventHandler("sysDownloadDone", function() tempTimer(1, function() self.config_window:reload_page() showWindow(self.config_window.window_name) end) end)
        registerAnonymousEventHandler("gmcp.char.options", function() self.screen_width = gmcp.char.options.screen_width self.config_window:reload_page() end)

        sendGMCP("Char.Options")
    end
    
    self.config_window:open()
end

function scripts.first_time_config.install_package(package)
    installPackage(getMudletHomeDir() .. "/arkadia/packages/".. package .. ".xml")
    scripts.first_time_config.package_installed[package] = true
    tempTimer(1, function() self.config_window:reload_page() end )
end

function scripts.first_time_config.base_and_map(window_page, index)
    cecho(window_page.name, "Wstepna konfiguracja skryptow\n")
    cecho(window_page.name, "-------------------\n")
    cecho(window_page.name, "Ponizej znajduje sie kilka podstawowych opcji konfiguracyjnych. Po zamknieciu tego okna, nie pojawi sie ono wiecej, chyba, ze wpiszesz <tomato>/konfiguracja<reset>")
    cecho(window_page.name, "\n\n")
    cecho(window_page.name, "opcje szerokosc 0\n")
    cecho(window_page.name, "-------------------\n")
    if scripts.first_time_config.screen_width == nil then
        cechoLink(window_page.name, "<red>X<reset> Nie moge wykryc ustawionej szerokosci. Kliknij <light_slate_blue>tutaj<reset>, zeby polaczyc sie z Arkadia", [[connectToServer("arkadia.rpg.pl", 23, false)]], "Laczenie sie z Arkadia", true)
    elseif scripts.first_time_config.screen_width ~= 0 then
        cechoLink(window_page.name, string.format("<red>X<reset> Nieprawilowa wartosc opcji szerokosc (%d). Skrypty nie beda dzialac prawidlowo. Kliknij <light_slate_blue>tutaj<reset> aby ustawic prawidlowa.", scripts.first_time_config.screen_width), [[sendGMCP("Char.Options {\"screen_width\":0}")]], "Ustaw szerokosc", true)
    else
        cecho(window_page.name, "<green>✓<reset> Prawidlowe ustawienie 'opcje szerokosc 0'")
    end
    cecho(window_page.name, "\n\n")
    cecho(window_page.name, "Konfiguracja postaci\n")
    cecho(window_page.name, "-------------------\n")
    if not scripts.config then
        cecho(window_page.name, "<red>X<reset> Nie masz utworzonej/zaladowanej konfiguracji postaci.\n")
        if gmcp.char and gmcp.char.info and gmcp.char.info.name and amap.logged_name then
            local create_config_code = string.format([[scripts_init_v2_config("%s", "%s") scripts.first_time_config.config_window:reload_page()]], string.proper_case(gmcp.char.info.name), amap.logged_name)
            cechoLink(window_page.name, string.format("Wpisz <tomato>/cinit %s %s<reset> lub kliknij <light_slate_blue>tutaj<reset>", string.proper_case(gmcp.char.info.name), amap.logged_name), create_config_code, "Tworzenie konfiguracji", true)
        else
            cechoLink(window_page.name, "Nie moge wykryc imienia do konfiguracj. Kliknij <light_slate_blue>tutaj<reset>, zeby polaczyc sie z Arkadia", [[connectToServer("arkadia.rpg.pl", 23, false)]], "Laczenie sie z Arkadia", true)
        end
    else
        cecho(window_page.name, "<green>✓<reset> Masz zaladowana konfiguracje postaci.")
    end
    cecho(window_page.name, "\n\n")
    cecho(window_page.name, "Baza danych postaci\n")
    cecho(window_page.name, "-------------------\n")
    if #db:fetch(scripts.people.db.people) == 0 then
        cecho(window_page.name, "<red>X<reset> Nie masz pobranej bazy postaci.\n")
        cechoLink(window_page.name, "Wpisz <tomato>/pobierz_baze<reset> lub kliknij <light_slate_blue>tutaj<reset>", [[alias_func_skrypty_installer_download_people_db()]], "Pobieranie bazy", true)
    else
        cecho(window_page.name, "<green>✓<reset> Masz juz pobrana baze postaci.")
    end
    cecho(window_page.name, "\n\n")
    cecho(window_page.name, "Mapa\n")
    cecho(window_page.name, "-------------------\n")
    if not io.exists(getMudletHomeDir() .. "/map_master3.dat") then
        cecho(window_page.name, "<red>X<reset> Nie masz pobranej mapy.\n")
        cechoLink(window_page.name, "Wpisz <tomato>/pobierz_mape<reset> lub kliknij <light_slate_blue>tutaj<reset>", [[alias_func_skrypty_installer_download_map()]], "Pobieranie mapy", true)
    else
    
        cecho(window_page.name, "<green>✓<reset> Masz juz pobrana mape.")
        amap:locate(true)
    end
    cecho(window_page.name, "\n\n")
    cecho(window_page.name, "Poruszanie sie\n")
    cecho(window_page.name, "-------------------\n")
    if not scripts.first_time_config.package_installed["numpad_keys"] then
        cechoLink(window_page.name, "- <light_slate_blue>Zainstaluj<reset> poruszanie sie klawiatura numeryczna<reset>", [[scripts.first_time_config.install_package("numpad_keys")]], "Instalacja poruszania sie klawiatura numeryczna", true)
    else 
        cecho(window_page.name, "<green>✓<reset> Poruszanie sie klawiatura numeryczna zainstalowane.")
    end
    echo(window_page.name, "\n")
    if not scripts.first_time_config.package_installed["alternative_keys"] then
        cechoLink(window_page.name, "- <light_slate_blue>Zainstaluj<reset> poruszanie sie ctrl+alt+uiojklnm,<reset>", [[scripts.first_time_config.install_package("alternative_keys")]], "Instalacja poruszania sie bez klawiatury numerycznej", true)
    else 
        cecho(window_page.name, "<green>✓<reset> Poruszanie sie ctrl+alt+uiojklnm, zainstalowane.")
    end
end

function scripts.first_time_config.plugins(window_page, index)
    cecho(window_page.name, "Polecane wtyczki do skryptow:")
    echo(window_page.name, "\n\n\n")
    cecho(window_page.name, "Mudlet Map Reader\n")
    cecho(window_page.name, "-----------------\n")
    cechoLink(window_page.name, "Opis: <light_slate_blue>https://github.com/Delwing/mudlet-map-reader<reset>\n", [[openUrl("https://github.com/Delwing/mudlet-map-reader")]], "", true)
    cechoLink(window_page.name, "Zainstaluj: <light_slate_blue>kliknij<reset>\n", [[scripts.plugins_installer.install_from_url(scripts.plugins_installer, "https://codeload.github.com/Delwing/mudlet-map-reader/zip/master")]], "", true)
    echo(window_page.name, "\n\n")
    cecho(window_page.name, "Arkadia Config Editor\n")
    cecho(window_page.name, "-----------------\n")
    cechoLink(window_page.name, "Opis: <light_slate_blue>https://github.com/Delwing/arkadia-cfg-editor<reset>\n", [[openUrl("https://github.com/Delwing/arkadia-cfg-editor)]], "", true)
    cechoLink(window_page.name, "Zainstaluj: <light_slate_blue>kliknj<reset>", [[scripts.plugins_installer.install_from_url(scripts.plugins_installer, "https://codeload.github.com/Delwing/arkadia-cfg-editor/zip/master")]], "", true)
end

function alias_func_first_time_config()
    scripts.first_time_config:init()
end