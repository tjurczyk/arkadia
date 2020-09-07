function migrate_config_to_config_v2(name)
    local config_schema_file = getMudletHomeDir() .. "/arkadia/config_schema.json"
    local config = nil
    local file = io.open(config_schema_file, "rb")
    if file then
        config = yajl.to_value(file:read("*a"))
        file:close()
    else
        error("config schema file doesn't exist")
    end

    scripts.config = ScriptsConfig:init(config, name, true)
    scripts.config:save_config(true)
    scripts:print_log("kopiuje aktualna konfiguracje...")
    for _, var in pairs(scripts.config._sorted_var_keys) do
        local value = scripts.config:_get_mudlet_var(var)
        scripts.config._config[var] = value
    end
    scripts:print_log("ok, zapisuje aktualna konfiguracje...")
    scripts.config:save_config(false)
end
