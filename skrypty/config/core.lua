local config_schema_file = getMudletHomeDir() .. "/arkadia/config_schema.json"
local file = io.open(config_schema_file, "rb")
if file then
    scripts.config_schema = yajl.to_value(file:read("*a"))
    file:close()
else
    error("config schema file doesn't exist")
end

function scripts_load_v2_config(name)
    scripts.config = ScriptsConfig:init(name, false)
    if scripts.config then
        scripts:print_log("laduje config dla profilu '" .. name .. "'", true)
        scripts.config:load_config()
        misc_load_dump()
        scripts.config:run_macro('_profile_loaded')
        tempTimer(4.0, function ()
            raiseEvent("profileLoaded")
            end
        )
    end
end

function scripts_init_v2_config(name, wolacz)
    if io.exists(scripts_config_path(name)) then
        scripts:print_log("konfiguracja dla '" .. name .. "' juz istnieje")
    else
        scripts.config = ScriptsConfig:init(name, true)
        if not scripts.config then
            scripts:print_log("config nie zostal zainicjowany prawidlowo, to nie powinno sie zdarzyc, zglos na discordzie")
            error("scripts.config is nil in scripts_init_v2_config()")
        end
        self:load_config(true)
        scripts.config:set_var("scripts.character_name", name, false, false, true)
        scripts.config:set_var("amap.locating.name", wolacz, false, false, true)
        scripts.config:save_config(true)

        local trigger_name = name .. "-login"
        if exists(trigger_name, "trigger") == 0 then
            local code = "scripts_load_v2_config(\"" .. name .. "\")"
            permRegexTrigger(trigger_name, "", { "Witaj, " .. wolacz .. ". Podaj swe haslo" }, code)
        else
            scripts:print_log("nie tworze triggera ladujacego config, bo taki juz istnieje.\n\n (1) wejdz w 'Triggers' w gornym pasku\n (2) odnajdz trigger, ktory laduje twoj config, prawdopodobnie bedzie mial w nazwie '<twoje imie>-login', lub cos podobnego\n (3) zamien jego tresc z czegos w stylu 'scripts_load_config(\"<twoje_imie>\")' na 'scripts_load_v2_config(\"<twoje_imie>\")'\n (4) po restarcie mudleta powinien zaladowac sie nowy config, stary plik imie.txt mozna wyrzucic\n\n")
        end
        scripts:print_log("utworzona konfiguracja dla " .. name .. " w pliku " .. scripts_config_path(name))
    end
end

function migrate_config_to_config_v2(name)
    local config = nil
    scripts.config = ScriptsConfig:init(name, true)
    if not scripts.config then
        error('scripts.config is nil in migrate_config_to_config_v2()')
    end

    scripts:print_log("kopiuje aktualna konfiguracje...")
    for _, var in pairs(scripts.config._sorted_var_keys) do
        local value = scripts.config:_get_mudlet_var(var)
        scripts.config._config[var] = value
    end
    scripts:print_log("ok, zapisuje aktualna konfiguracje...")
    scripts.config:save_config(true)
    scripts:print_log("UWAGA: teraz wymagane sa nastepujace kroki:\n\n (1) wejdz w 'Triggers' w gornym pasku\n (2) odnajdz trigger, ktory laduje twoj config, prawdopodobnie bedzie mial w nazwie '<twoje imie>-login', lub cos podobnego\n (3) zamien jego tresc z czegos w stylu 'scripts_load_config(\"<twoje_imie>\")' na 'scripts_load_v2_config(\"<twoje_imie>\")'\n (4) po restarcie mudleta powinien zaladowac sie nowy config, stary plik imie.txt mozna wyrzucic\n\n", true)
end

function scripts_config_path(file_name)
    return getMudletHomeDir() .. "/" .. file_name .. ".json"
end
