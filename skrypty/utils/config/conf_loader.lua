-- TODO(dzordzyk): to be deprecated

scripts.config_loader = scripts.config_loader or {}

function scripts.config_loader:get_config_path(name)
    return getMudletHomeDir() .. "/" .. name .. ".txt"
end

function scripts_load_config(name)
    scripts:print_log("Wyglada na to, ze uzywasz starego systemu konfiguracji. Dokonaj migracji do nowego systemu, skrypty moga dzialac niepoprawnie", true)
        scripts.config_loader.last_config = name
        load_my_settings = nil
        local ok, result, err = pcall(loadfile, scripts.config_loader:get_config_path(name))
        if result then
            tempTimer(0.3, function ()
                result()
                if not load_my_settings then
                    scripts:print_log("Ok, profil " .. name .. " zaladowany, ale nie zaaplikowany. Dokonaj migracji na nowy system")
                else
                    scripts:print_log("Masz stary plik imie.txt. Zalecana aktualizacja. Aktualny domyslny plik znajdziesz w " .. getMudletHomeDir() .. "/arkadia/imie.txt")
                end
            end)
        end
end
