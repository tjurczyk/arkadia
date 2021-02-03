-- TODO(dzordzyk): to be deprecated

scripts.config_loader = scripts.config_loader or {}

function scripts.config_loader:get_config_path(name)
    return getMudletHomeDir() .. "/" .. name .. ".txt"
end

function scripts_load_config(name, silent)
    if not silent then
        scripts:print_log("Wyglada na to, ze uzywasz starego systemu konfiguracji. Dokonaj migracji do nowego systemu, skrypty moga dzialac niepoprawnie", true)
    end
    scripts.config_loader.last_config = name
    load_my_settings = nil
    local ok, result, err = pcall(loadfile, scripts.config_loader:get_config_path(name))
    if result then
        result()
        if not silent then
            if not load_my_settings then
                scripts:print_log("Ok, profil " .. name .. " zaladowany, ale nie zaaplikowany. Dokonaj migracji na nowy system")
                scripts:print_url("<deep_sky_blue>kliknij tutaj po pomoc do nowego systemu", "alias_config_open_help_url", "klik")
            else
                scripts:print_log("Masz stary plik imie.txt. Zalecana aktualizacja. Aktualny domyslny plik znajdziesz w " .. getMudletHomeDir() .. "/arkadia/imie.txt")
            end
        end
    end
end
