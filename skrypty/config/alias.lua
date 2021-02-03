function alias_config_help()

    cecho("+------------------------ <green>Arkadia skrypty, ver " .. string.sub(scripts.ver .. "   ", 0, 4) .. "<grey> -------------------------+\n")
    cecho("|                                                                            |\n")
    cecho("| <yellow>Aby zobaczyc pomoc ")
    scripts:print_url("<deep_sky_blue>kliknij tutaj", "alias_config_open_help_url", "klik")
    cecho("                                           |\n")
    cecho("|                                                                            |\n")
    cecho("| <yellow>Aby zobaczyc opisy kluczy konfiguracyjnych ")
    scripts:print_url("<deep_sky_blue>kliknij tutaj", "open_cfg_keys", "klik")
    cecho("                   |\n")
    cecho("|                                                                            |\n")
    cecho("+----------------------------------------------------------------------------+\n")
end

function open_cfg_keys()
    openUrl("https://github.com/tjurczyk/arkadia/blob/master/config.md")
end

function alias_config_open_help_url()
    openUrl("http://arkadia.kamerdyner.net/config.html")
end

function alias_config_load()
    scripts_load_v2_config(matches[2])
end

function alias_config_save()
    if not scripts.config then
        scripts:print_log("config niezainicjowany")
        return
    end
    scripts.config:save_config{silent=false}
end

function alias_config_migrate()
    migrate_config_to_config_v2(matches[2])
end

function alias_config_get_var()
    if matches[2] == nil then
        scripts.config:print_var{var_pattern=".*"}
    else
        local var_pattern = matches[2]
        scripts.config:print_var{var_pattern=var_pattern}
    end
end

function alias_config_add_var()
    local success = scripts.config:add_custom_var{var_name=matches[2], var_type=matches[3]}
    if success then
        scripts.config:save_config{silent=true}
    end
end

function alias_config_set_var()
    local run_macros = false
    local skip_validation_test = false
    if matches[2] == '!!' then
        skip_validation_test = true
    elseif matches[2] == '!' then
        run_macros = true
    end

    local var = matches[3]
    local value = alias_config_parse_value_to_type_value(matches[4])

    if value == nil then
        scripts:print_log("problem ze sparsowaniem wartosci: '" .. matches[4] .. "'")
        error("value parsing error in alias_config_set_var()")
    end
    local success = scripts.config:set_var{
        var=var,
        value=value,
        run_macros=run_macros,
        skip_validation_test=skip_validation_test
    }
    if success then
        scripts.config:save_config{silent=true}
    end
end

function alias_config_set_var_index()
    local run_macros = false
    local skip_validation_test = false
    if matches[2] == '!!' then
        skip_validation_test = true
    elseif matches[2] == '!' then
        run_macros = true
    end

    local var = matches[3]
    local index = alias_config_parse_value_to_type_value(matches[4])
    local value = alias_config_parse_value_to_type_value(matches[5])

    if index == nil then
        scripts:print_log("problem ze sparsowaniem indeksu: '" .. matches[4] .. "'")
        error("index parsing error in alias_config_set_var_index()")
    end

    if value == nil then
        scripts:print_log("problem ze sparsowaniem wartosci: '" .. matches[5] .. "'")
        error("index parsing error in alias_config_set_var_index()")
    end

    local success = scripts.config:set_indexed_var{
        var=var,
        value_key=index,
        value_value=value,
        run_macros=run_macros,
        skip_validation_test=skip_validation_test,
    }
    if success then
        scripts.config:save_config{silent=true}
    end
end

function alias_config_del_var_index_key()
    local run_macros = false
    local skip_validation_test = false
    if matches[2] == '!!' then
        skip_validation_test = true
    elseif matches[2] == '!' then
        run_macros = true
    end

    local var = matches[3]
    local key = alias_config_parse_value_to_type_value(matches[4])

    if key == nil then
        scripts:print_log("problem ze sparsowaniem indeksu: '" .. matches[4] .. "'")
        error("index parsing error in alias_config_del_var_index_key()")
    end

    local success = scripts.config:remove_indexed_var{
        var=var,
        value_key=key,
        run_macros=run_macros,
        skip_validation_test=skip_validation_test,
    }
    if success then
        scripts.config:save_config{silent=true}
    end
end

function alias_config_del_var_index_value()
    local run_macros = false
    local skip_validation_test = false
    if matches[2] == '!!' then
        skip_validation_test = true
    elseif matches[2] == '!' then
        run_macros = true
    end

    local var = matches[3]
    local value = alias_config_parse_value_to_type_value(matches[4])

    if value == nil then
        scripts:print_log("problem ze sparsowaniem wartosci: '" .. matches[4] .. "'")
        error("index parsing error in alias_config_del_var_index_value()")
    end

    local success = scripts.config:remove_indexed_var{
        var=var,
        value_value=value,
        run_macros=run_macros,
        skip_validation_test=skip_validation_test,
    }
    if success then
        scripts.config:save_config{silent=true}
    end
end

function alias_config_parse_value_to_type_value(value_from_matches)
    if value_from_matches == "true" then
        return true
    elseif value_from_matches == "false" then
        return false
    elseif string.sub(value_from_matches, 1, 1) == "\"" and string.sub(value_from_matches, #value_from_matches, #value_from_matches) == "\"" then
        return string.sub(value_from_matches, 2, #value_from_matches-1)
    else
        return tonumber(value_from_matches)
    end
end

function alias_func_init_config(name, wolacz)
    scripts_init_v2_config(name, wolacz)
end
