scripts.config_loader = scripts.config_loader or {}

function scripts.config_loader:init_name_file(name, wolacz)
    if self:has_config_file(name) then
        scripts:print_log("Konfiguracja dla " .. name .. " juz istnieje")
    else
        self:copy_initial_config(name, wolacz)
        self:add_trigger(name, wolacz)
        scripts:print_log("Utworzona konfiguracja dla " .. name .. " w pliku " .. self:get_config_path(name))
    end
end

function scripts.config_loader:copy_initial_config(name, wolacz)
    local config_path = self:get_config_path(name)
    pcall(os.remove, config_path)
    local source = io.open(getMudletHomeDir() .. "/arkadia/imie.txt", "r")
    local content = source:read("*a")
    content = content:gsub("scripts\.character_name = nil", "scripts.character_name = \"" .. name .. "\"")
    content = content:gsub("amap\.locating\.name = \"Adremenie\"", "amap.locating.name = \"" .. wolacz .. "\"")
    local destination = io.open(self:get_config_path(name), "w")
    destination:write(content)
    destination:close()
end

function scripts.config_loader:add_trigger(name, wolacz)
    local trigger_name = name .. "-login"
    if exists(trigger_name, "trigger") == 0 then
        local code = "scripts_load_config(\"" .. name .. "\")"
        permRegexTrigger(trigger_name, "", { "Witaj, " .. wolacz .. ". Podaj swe haslo" }, code)
    end
end

function scripts.config_loader:has_config_file(name)
    return io.exists(self:get_config_path(name))
end

function scripts.config_loader:get_config_path(name)
    return getMudletHomeDir() .. "/" .. name .. ".txt"
end

function scripts.config_loader:reload_last_config()
    if self.last_config then
        scripts_load_config(self.last_config)
    end
end

function scripts_load_config(name)
    scripts.config_loader.last_config = name
    load_my_settings = nil
    local ok, result, err = pcall(loadfile, scripts.config_loader:get_config_path(name))
    if result then
        raiseEvent("profileLoaded")
        tempTimer(0.3, function ()
            result()
            if not load_my_settings then
                after_profile_load()
                scripts:print_log("Ok, profil " .. name .. " zaladowany")
            else
                scripts:print_log("Masz stary plik imie.txt. Zalecana aktualizacja.")
            end
        end)
    else
        scripts:print_log([[Blad podczas ladowania pliku ustawien.
            - przecinki
            - cudzyslowia
            - apostrofy
            - nawiasy]])
        scripts:print_log("Szczegoly bledu:")
        scripts:print_log("<slate_grey> " .. err)
        resetFormat()
    end
end

function after_profile_load()
    tempTimer(0.4, function () misc_load_dump() end)
    tempTimer(0.4, function () scripts.people:enemy_people_starter() end)
    tempTimer(0.4, function () ateam:set_ateam_options() end)
    tempTimer(0.47, function () scripts.keybind:init() end)
    tempTimer(0.55, function () scripts.people:color_people_starter() end)
    tempTimer(0.7, function () scripts.people:trigger_people_starter() end)
    tempTimer(1, function () scripts.ui:setup() end)
    tempTimer(1.1, function() amap:check_room_gps_options() end)
    tempTimer(1.5, function () scripts.ui:set_gag_options() end)
    tempTimer(1.7, function () misc.lang:init() end)
    tempTimer(1.8, function () scripts.people:build_bind_table() end)
    tempTimer(1.9, function () herbs:init_herbs() end)
    tempTimer(2.0, function () scripts.inv:set_all_magic() end)
end

function alias_func_init_config(name, wolacz)
    scripts.config_loader:init_name_file(name, wolacz)
end
