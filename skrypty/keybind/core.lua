function scripts.keybind:init()
    -- delete all keys if exist
    scripts.keybind:delete_temp_keybinds()

    for bind, b_dict in pairs(scripts.keybind.configuration) do
        -- backward compatibility for attack_binds
        if bind ~= "attack_bind_obj" then
            scripts.keybind:create_temp_keybind(bind, b_dict["active"], b_dict["description"], "core", b_dict["modifier"], b_dict["key"], b_dict["keys"], b_dict["callback"])
        end
    end

    -- disable temps
    scripts.temp_binds.unbind_temp(true)

    scripts:print_log("keybindy zaladowane")
end

function scripts.keybind:delete_temp_keybinds()
    for k, v in pairs(scripts.keybind.ids) do
        if type(k) == "number" then
            killKey(k)
        end
    end

    scripts.keybind.ids = {}
end

function scripts.utils.disable_keybinds(silent)
    for k, v in pairs(scripts.keybind.ids) do
        if type(k) == "number" then
            disableKey(k)
        end
    end

    if not silent then
        scripts:print_log("Keybindy wylaczone")
    end
end

function scripts.utils.enable_keybinds(silent)
    for k, v in pairs(scripts.keybind.ids) do
        if type(k) == "number" then
            enableKey(k)
        end
    end

    if not silent then
        scripts:print_log("Keybindy wlaczone")
    end
end

function scripts.keybind:create_temp_keybind(name, is_active, desc, group, modifier, key, keys, callback)
    if is_active ~= true then
        -- if bind is not active, don't initiate.
        return
    end

    if not modifier or not key or not callback then
        error("Wrong input")
    end

    local modifier_value = 0
    for _, id in pairs(modifier) do
        if not mudlet.keymodifier[id] then
            scripts:print_log("nieznany modifier: " .. id, true)
            error("Wrong modifier")
        end

        modifier_value = modifier_value + mudlet.keymodifier[id]
    end

    if key ~= "" then
        scripts.keybind:_build_single_key(name, desc, group, modifier, modifier_value, key, callback, nil)
        key = { key }
    elseif table.size(keys) > 0 then
        for idx, single_key in pairs(keys) do
            scripts.keybind:_build_single_key(name .. "_" .. idx, desc, group, modifier, modifier_value, single_key, callback, idx)
        end
    else
        scripts:print_log("nieznana sekwencja typu w keybindach", true)
        error("Wrong type of key var")
    end
end

function scripts.keybind:_build_single_key(name, desc, group, modifier, modifier_value, key, callback, param)
    if not mudlet.key[key] then
        scripts:print_log("nieznany key: " .. key, true)
        error("Wrong key")
    end

    if not _G[callback] then
        scripts:print_log("nieznany callback: " .. callback, true)
        error("Wrong key")
    end

    local l_param = nil
    if not param then
        l_param = ""
    else
        l_param = param
    end

    local k_id = tempKey(modifier_value, mudlet.key[key], callback .. [[ (]] .. l_param .. [[) ]])
    scripts.keybind.ids[k_id] = name
    scripts.keybind.ids[name] = {
        ["modifier"] = modifier,
        ["key"] = key,
        ["param"] = l_param,
        ["callback"] = callback,
        ["id"] = k_id,
        ["description"] = desc,
        ["group"] = group
    }

    scripts.keybind.ids[name]["printable"] = scripts.keybind:_construct_printable(name)
end

function scripts.keybind:_construct_printable(name)
    if not scripts.keybind.ids[name] then
        error("Wrong name")
    end

    local str = ""
    for k, v in pairs(scripts.keybind.ids[name].modifier) do
        str = str .. scripts.keybind.printable_items[v] .. " + "
    end

    if scripts.keybind.printable_items[scripts.keybind.ids[name].key] then
        str = str .. scripts.keybind.printable_items[scripts.keybind.ids[name].key]
    else
        str = str .. scripts.keybind.ids[name].key
    end

    return str
end

function scripts.keybind:keybind_tostring(name)
    if not scripts.keybind.ids[name] then
        error("Wrong name")
    end

    return scripts.keybind.ids[name].printable
end

function scripts.keybind:disable_keybind(name)
    if not scripts.keybind.ids[name] then
        error("Wrong name")
    end

    disableKey(scripts.keybind.ids[name].id)
end

function scripts.keybind:enable_keybind(name)
    if not scripts.keybind.ids[name] then
        error("Wrong name")
    end

    enableKey(scripts.keybind.ids[name].id)
end

function scripts.keybind:pretty_print()
    local color_table = { [0] = "<orange>", [1] = "<orange>" }
    local inc = 0

    cecho("+------------------------- <green>Arkadia skrypty, ver " .. string.sub(scripts.ver .. "    ", 0, 5) .. "<grey> ---------------------------+\n")
    cecho("|                                                                                |\n")
    cecho("| <yellow>Skonfigurowane BINDY:<grey>                                                          |\n")
    cecho("|                                                                                |\n")
    cecho("| <orange>WALKA<grey>                                                                          |\n")
    cecho("|                                                                                |\n")
    cecho(scripts.keybind:_pretty_element_string("attack_target", scripts.keybind.ids["attack_target"]))
    cecho(scripts.keybind:_pretty_element_string("fight_support", scripts.keybind.ids["fight_support"]))

    -- assuming max is 20
    for var = 1, 20 do
        local attack_bind_name = "attack_bind_objs_" .. tostring(var)
        if scripts.keybind.ids[attack_bind_name] then
            cecho(scripts.keybind:_pretty_element_string(attack_bind_name, scripts.keybind.ids[attack_bind_name]))
        else
            break
        end
    end

    cecho(scripts.keybind:_pretty_element_string("break_attack_target", scripts.keybind.ids["break_attack_target"]))
    cecho(scripts.keybind:_pretty_element_string("block_attack_target", scripts.keybind.ids["block_attack_target"]))
    cecho(scripts.keybind:_pretty_element_string("critical_hp", scripts.keybind.ids["critical_hp"]))
    cecho("|                                                                                |\n")
    cecho("| <orange>INWENTARZ<grey>                                                                      |\n")
    cecho("|                                                                                |\n")
    cecho(scripts.keybind:_pretty_element_string("collect_from_body", scripts.keybind.ids["collect_from_body"]))
    cecho(scripts.keybind:_pretty_element_string("filling_lamp", scripts.keybind.ids["filling_lamp"]))
    cecho(scripts.keybind:_pretty_element_string("empty_bottle", scripts.keybind.ids["empty_bottle"]))
    cecho("|                                                                                |\n")
    cecho("| <orange>PORUSZANIE SIE<grey>                                                                 |\n")
    cecho("|                                                                                |\n")
    cecho(scripts.keybind:_pretty_element_string("enter_ship", scripts.keybind.ids["enter_ship"]))
    cecho(scripts.keybind:_pretty_element_string("opening_gate", scripts.keybind.ids["opening_gate"]))
    cecho(scripts.keybind:_pretty_element_string("drinking", scripts.keybind.ids["drinking"]))
    cecho(scripts.keybind:_pretty_element_string("special_exit", scripts.keybind.ids["special_exit"]))
    cecho(scripts.keybind:_pretty_element_string("walk_mode", scripts.keybind.ids["walk_mode"]))
    cecho("|                                                                                |\n")
    cecho("| <orange>MULTIBINDY LOKACJI<grey>                                                             |\n")
    cecho("|                                                                                |\n")
    cecho(scripts.keybind:_pretty_element_string("multibind1", scripts.keybind.ids["multibind1"]))
    cecho(scripts.keybind:_pretty_element_string("multibind2", scripts.keybind.ids["multibind2"]))
    cecho(scripts.keybind:_pretty_element_string("multibind3", scripts.keybind.ids["multibind3"]))
    cecho(scripts.keybind:_pretty_element_string("multibind4", scripts.keybind.ids["multibind4"]))
    cecho("|                                                                                |\n")
    cecho("| <orange>ROZNE<grey>                                                                          |\n")
    cecho("|                                                                                |\n")
    cecho(scripts.keybind:_pretty_element_string("functional_key", scripts.keybind.ids["functional_key"]))
    cecho(scripts.keybind:_pretty_element_string("temp1", scripts.keybind.ids["temp1"]))
    cecho(scripts.keybind:_pretty_element_string("temp2", scripts.keybind.ids["temp2"]))
    cecho(scripts.keybind:_pretty_element_string("temp3", scripts.keybind.ids["temp3"]))
    cecho(scripts.keybind:_pretty_element_string("temp4", scripts.keybind.ids["temp4"]))
    for i = 5, 10 do
        if scripts.keybind.configuration["temp" .. i]["active"] then
            cecho(scripts.keybind:_pretty_element_string("temp" .. i, scripts.keybind.ids["temp" .. i]))
        end
    end
    cecho("|                                                                                |\n")
    cecho("+--------------------------------------------------------------------------------+\n")
end

function scripts.keybind:_pretty_element_string(name, elem)
    local str = "| <light_slate_blue>" .. scripts.keybind:keybind_tostring(name) .. "<grey> - " .. elem["description"]
    str = string.sub(str .. "                                                                                          ", 0, 104)
    str = str .. " |\n"
    return str
end

tempTimer(0.4, function() scripts.keybind:init() end)
tempTimer(0.6, function() scripts.people:build_bind_table() end)

