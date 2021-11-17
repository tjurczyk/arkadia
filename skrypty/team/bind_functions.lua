function ateam:zas_func(id)
    if ateam.enemy_op_ids[tonumber(id)] then
        local real_id = ateam.enemy_op_ids[tonumber(id)]
        send("zaslon przed ob_" .. real_id, false)
        if ateam.release_guards then
            send("przestan zaslaniac", false)
        end
    else
        scripts:print_log("Nie ma takiego id")
    end
end

function ateam:za_func(id)
    if ateam.team[id] then
        local real_id = ateam.team[id]
        sendAll("przestan kryc sie za zaslona", "zaslon ob_" .. real_id, false)
        if ateam.release_guards then
            send("przestan zaslaniac", false)
        end
    else
        scripts:print_log("Nie ma takiego id")
    end
end

function ateam:za_func_def()
    sendAll("przestan kryc sie za zaslona", "zaslon cel obrony", false)
    if ateam.release_guards then
        send("przestan zaslaniac", false)
    end
end

function ateam:za_func_support(teammate, id)
    if ateam.team[string.upper(teammate)] and ateam.enemy_op_ids[tonumber(id)] then
        local real_teammate = ateam.team[string.upper(teammate)]
        local real_id = ateam.enemy_op_ids[tonumber(id)]
        sendAll("przestan kryc sie za zaslona", "zaslon ob_" .. real_teammate .. " przed ob_" .. real_id, false)
        if ateam.release_guards then
            send("przestan zaslaniac", false)
        end
    else
        scripts:print_log("Nie ma takiego id")
    end
end

function ateam:za_func_group(id, number)
    send("opcje grupa " .. tostring(number), false)
    if not id then
        sendAll("przestan kryc sie za zaslona", "zaslon cel obrony", false)
        if ateam.release_guards then
            send("przestan zaslaniac", false)
        end
    elseif ateam.team[string.upper(id)] then
        local real_id = ateam.team[string.upper(id)]
        sendAll("przestan kryc sie za zaslona", "zaslon ob_" .. real_id, false)
        if ateam.release_guards then
            send("przestan zaslaniac", false)
        end
    else
        scripts:print_log("Nie ma takiego id")
    end
    send("opcje grupa 1", false)
end

function ateam:get_attack_string()
    return table.concat(ateam.attack_commands, ";") .. " "
end

function ateam:zab_func(id)
    local id_retrieved = nil

    if id ~= nil and tonumber(id) > 100 then
        -- TODO: Maybe find a better way to check whether the number is raw?
        id_retrieved = "ob_" .. id
    elseif ateam.enemy_op_ids[tonumber(id)] then
        id_retrieved = "ob_" .. ateam.enemy_op_ids[tonumber(id)]
    elseif ateam.normal_ids[tonumber(id)] then
        id_retrieved = "ob_" .. ateam.normal_ids[tonumber(id)]
    elseif string.starts(id, "ob") == true then
        id_retrieved = id
    end

    if id_retrieved then
        local local_str = id_retrieved
        send(ateam:get_attack_string() .. local_str, true)

        if table.size(ateam.team) > 1 and ateam:is_leader() and ateam.attack_mode > 1 then
            send("wskaz " .. local_str .. " jako cel ataku", false)

            if ateam.attack_mode > 2 then
                send("rozkaz druzynie zaatakowac " .. local_str, false)
            end
        end
    else
        scripts:print_log("Nie ma takiego id")
    end
end

function ateam:sneaky_zab_func(id)
    local id_retrieved = nil

    if tonumber(id) > 100 then
        -- TODO: Maybe find a better way to check whether the number is raw?
        id_retrieved = "ob_" .. id
    elseif ateam.enemy_op_ids[tonumber(id)] then
        id_retrieved = "ob_" .. ateam.enemy_op_ids[tonumber(id)]
    elseif ateam.normal_ids[tonumber(id)] then
        id_retrieved = "ob_" .. ateam.normal_ids[tonumber(id)]
    elseif string.starts(id, "ob") == true then
        id_retrieved = id
    end

    if id_retrieved then
        local local_str = id_retrieved
        send("zaskocz " .. local_str, false)
    else
        scripts:print_log("Nie ma takiego id")
    end
end

function ateam:zab2_func(desc)
    send(ateam:get_attack_string() .. desc, false)

    if table.size(ateam.team) > 1 and ateam:is_leader() and ateam.attack_mode > 1 then
        send("wskaz " .. desc .. " jako cel ataku", false)

        if ateam.attack_mode > 2 then
            send("rozkaz druzynie zaatakowac " .. desc, false)
        end
    end
end

function ateam:sneaky_zab2_func(id)
    send("zaskocz " .. id, false)
end

function ateam:zab3_func(obj_id)
    local obj = "ob_" .. tostring(obj_id)
    send(ateam:get_attack_string() .. obj, false)

    if table.size(ateam.team) > 1 and ateam:is_leader() and ateam.attack_mode > 1 then
        send("wskaz " .. obj .. " jako cel ataku", false)

        if ateam.attack_mode > 2 then
            send("rozkaz druzynie zaatakowac " .. obj, false)
        end
    end
end

function ateam:prze_func(id, check_fatigue)
    if check_fatigue and scripts.character.state.fatigue > scripts.character.break_fatigue_level then
        return
    end

    if ateam.enemy_op_ids[tonumber(id)] then
        local real_id = ateam.enemy_op_ids[tonumber(id)]
        sendAll("przestan kryc sie za zaslona", "przelam obrone ob_" .. real_id, false)
        expandAlias("/z " .. id, false)
    else
        scripts:print_log("Nie ma takiego id")
    end
end

function ateam:def_func_clicked(id)
    if not ateam.clicked_second_defense then
        ateam.clicked_second_defense = true
        tempTimer(1.5, function() ateam.clicked_second_defense = false end)

        if id == "@" then
            send("wskaz siebie jako cel obrony", false)
        else
            local real_id = ateam.team[id]
            send("wskaz ob_" .. real_id .. " jako cel obrony", false)
        end
    else
        ateam.clicked_second_defense = false
        if id == "@" then
            send("rozkaz druzynie zaslonic ciebie", false)
        else
            local real_id = ateam.team[id]
            send("rozkaz druzynie zaslonic  ob_" .. real_id, false)
        end
    end
end

function ateam:rz_func(id)
    if id == "@" then
        sendAll("wskaz siebie jako cel obrony", "rozkaz druzynie zaslonic ciebie", false)
    elseif ateam.team[id] then
        local real_id = ateam.team[id]
        sendAll("wskaz ob_" .. real_id .. " jako cel obrony", "rozkaz druzynie zaslonic ob_" .. real_id, false)
    else
        scripts:print_log("Nie ma takiego id")
    end
end

function ateam:ra_func(id)
    if ateam.enemy_op_ids[tonumber(id)] then
        local real_id = ateam.enemy_op_ids[tonumber(id)]
        local local_str = "ob_" .. real_id
        sendAll("wskaz " .. local_str .. " jako cel ataku", "rozkaz druzynie zaatakowac " .. local_str, false)
    else
        scripts:print_log("Nie ma takiego id")
    end
end

function ateam:rb_func(id)
    if ateam.enemy_op_ids[tonumber(id)] then
        local real_id = ateam.enemy_op_ids[tonumber(id)]
        local local_str = "ob_" .. real_id
        send("rozkaz druzynie zablokowac " .. local_str, false)
    else
        scripts:print_log("Nie ma takiego id")
    end
end

function ateam:wz_func(id)
    if id == "@" then
        send("wskaz siebie jako cel obrony", false)
    elseif ateam.team[id] then
        local real_id = ateam.team[id]
        send("wskaz ob_" .. real_id .. " jako cel obrony", false)
    else
        scripts:print_log("Nie ma takiego id")
    end
end

function ateam:wa_func(id)
    if ateam.enemy_op_ids[tonumber(id)] then
        local real_id = ateam.enemy_op_ids[tonumber(id)]
        local local_str = "ob_" .. real_id
        send("wskaz " .. local_str .. " jako cel ataku", false)
    else
        scripts:print_log("Nie ma takiego id")
    end
end

function ateam:w_func(id)
    if ateam.team[id] then
        local real_id = ateam.team[id]
        local local_str = "ob_" .. real_id
        send("gzwycofaj sie za " .. local_str, false)
        if ateam.release_guards then
            send("przestan kryc sie za zaslona", false)
        end
    else
        scripts:print_log("Nie ma takiego id")
    end
end

function ateam:break_defense_func()
    if ateam.break_enemy_defense_id then
        sendAll("przestan kryc sie za zaslona", "przelam obrone ob_" .. ateam.break_enemy_defense_id, ateam:get_attack_string() .. " ob_" .. ateam.break_enemy_defense_id, false)
    end
end

function ateam:por_func(id)
    if not id then
        if ateam.my_id and ateam.objs[ateam.my_id] then
            if ateam.objs[ateam.my_id]["attack_num"] then
                -- only if attack_num is ~= false for me
                local ob_desc = "ob_" .. ateam.objs[ateam.my_id]["attack_num"]
                sendAll("porownaj sile z " .. ob_desc, "porownaj zrecznosc z " .. ob_desc,
                    "porownaj wytrzymalosc z " .. ob_desc, false)
            else
                scripts:print_log("Nie walczysz z nikim")
                return
            end
        end
    else
        local id_retrieved = nil
        if ateam.enemy_op_ids[tonumber(id)] then
            id_retrieved = ateam.enemy_op_ids[tonumber(id)]
        elseif ateam.normal_ids[tonumber(id)] then
            id_retrieved = ateam.normal_ids[tonumber(id)]
        elseif string.find(id, "ob_") then
            sendAll("porownaj sile z " .. id, "porownaj zrecznosc z " .. id,
                "porownaj wytrzymalosc z " .. id, false)
            return
        end

        if id_retrieved then
            local ob_desc = "ob_" .. id_retrieved
            sendAll("porownaj sile z " .. ob_desc, "porownaj zrecznosc z " .. ob_desc,
                "porownaj wytrzymalosc z " .. ob_desc, false)
        else
            scripts:print_log("Nie ma takiego id")
            return
        end
    end
end

function ateam:por2_func(name)
    if name then
        sendAll("porownaj sile z " .. name, "porownaj zrecznosc z " .. name,
            "porownaj wytrzymalosc z " .. name, false)
    end
end

function ateam:bind_joining(name)
    local lowered_name = string.lower(name)
    local obj_to_join = nil

    for k, v in pairs(gmcp.objects.nums) do
        if ateam.objs[v]["desc"] == name or ateam.objs[v]["desc"] == lowered_name and not ateam.objs[v].enemy and not table.index_of(scripts.people.enemy_people)then
            obj_to_join = v
            break
        end
    end

    if table.size(scripts.people.enemy_guilds) > 0 then       
        local results = #string.split(name, " ") > 1 and scripts.people:search(name) or scripts.people:retrieve_person(name)
        local can_be_enemy = false
        for _, person in pairs(results) do
            if table.index_of(scripts.people.enemy_guilds, scripts.people:get_guild_name(person.guild)) then
                scripts:print_log(string.format("%s - cwaniak probuje zaprosic cie do druzyny. Wstyd!", name), true)
                return
            end
        end
    end

    if obj_to_join then
        scripts.utils.bind_functional("porzuc druzyne;dolacz do ob_" .. obj_to_join)
    end
end

function ateam:give_leader(id)
    if ateam.team[id] then
        local real_id = ateam.team[id]
        sendAll("przekaz prowadzenie ob_" .. real_id, false)
    else
        scripts:print_log("Nie ma takiego id")
    end
end

function ateam:zap_func(id)
    if ateam.normal_ids and ateam.normal_ids[tonumber(id)] then
        local real_id = ateam.normal_ids[tonumber(id)]
        send("zapros ob_" .. real_id, false)
    end
end

function ateam:block_func(id)
    local id_retrieved = nil

    if ateam.enemy_op_ids[tonumber(id)] then
        id_retrieved = ateam.enemy_op_ids[tonumber(id)]
    elseif ateam.normal_ids[tonumber(id)] then
        id_retrieved = ateam.normal_ids[tonumber(id)]
    end

    if id_retrieved then
        local real_id = id_retrieved
        local local_str = "ob_" .. real_id
        send("zablokuj " .. local_str, true)
    else
        scripts:print_log("Nie ma takiego id")
    end
end

