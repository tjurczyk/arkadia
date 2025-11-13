function ateam:zas_func(id)
    if ateam.enemy_op_ids[tonumber(id)] then
        local real_id = self:retrieve_id(id)
        send(string.format("%s przed %s", self.cover_command, real_id), false)
        if ateam.release_guards then
            send("przestan zaslaniac", false)
        end
    else
        scripts:print_log("Nie ma takiego id")
    end
end

function ateam:za_func(id)
    if ateam.team[id] then
        local real_id = self:retrieve_team_id(id)
        sendAll("przestan kryc sie za zaslona", string.format("%s %s", self.cover_command, real_id), false)
        if ateam.release_guards then
            send("przestan zaslaniac", false)
        end
    else
        scripts:print_log("Nie ma takiego id")
    end
end

function ateam:za_func_def()
    sendAll("przestan kryc sie za zaslona", string.format("%s cel obrony", self.cover_command), false)
    if ateam.release_guards then
        send("przestan zaslaniac", false)
    end
end

function ateam:za_func_support(teammate, id)
    local real_id = ateam:retrieve_id(id)
    local real_teammate_id = ateam:retrieve_team_id(teammate)
    if real_id and id then
        sendAll("przestan kryc sie za zaslona", string.format("%s %s przed %s", self.cover_command, real_teammate_id, real_id), false)
        if ateam.release_guards then
            send("przestan zaslaniac", false)
        end
    else
        scripts:print_log("Nie ma takiego id")
    end
end

function ateam:za_func_group(id, number)
    local restore = scripts.character.options:set_temporary("group_cover", number)
    if not id then
        sendAll("przestan kryc sie za zaslona", string.format("%s cel obrony", self.cover_command), false)
        if ateam.release_guards then
            send("przestan zaslaniac", false)
        end
    elseif ateam.team[string.upper(id)] then
        local real_id = ateam:retrieve_team_id(id)
        sendAll("przestan kryc sie za zaslona", string.format("%s %s", self.cover_command, real_id), false)
        if ateam.release_guards then
            send("przestan zaslaniac", false)
        end
    else
        scripts:print_log("Nie ma takiego id")
    end
    scripts.character.options:set_temporary("group_cover", 1)
end

function ateam:get_attack_string()
    return table.concat(ateam.attack_commands, ";") .. " "
end

function ateam:zab_func(id)
    local id_retrieved = self:retrieve_id(id)

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
    local id_retrieved = self:retrieve_id(id)
    if id_retrieved then
        local local_str = id_retrieved
        send("zaskocz " .. local_str, false)
    else
        scripts:print_log("Nie ma takiego id")
    end
end

local replace_szata = {
    ["mezyczna"] = "mezczyzne",
    ["kobieta"] = "kobiete",
    ["krasnolud"] = "krasnoluda",
    ["krasnoludka"] = "krasnoludke",
    ["elf"] = "elfa",
    ["elfka"] = "elfke",
    ["halfling"] = "halflinga",
    ["halflinka"] = "halflinke",
    ["niziolek"] = "niziolka",
    ["niziolka"] = "niziolke",
    ["polelf"] = "polelfa",
    ["polelfke"] = "polelfke",
    ["gnom"] = "gnoma",
    ["gnomka"] = "gnomke",
    ["ogr"] = "ogra",
    ["ogrzyca"] = "ogrzyce",
    ["mutant"] = "mutanta",
    ["mutantka"] = "mutantke"
}

local replace_szata_celownik = {
    ["mezczyzne"] = "mezczyznie",
    ["kobiete"] = "kobiecie",
    ["krasnoluda"] = "krasnoludowi",
    ["krasnoludke"] = "krasnoludce",
    ["elfa"] = "elfowi",
    ["elfke"] = "elfce",
    ["halflinga"] = "halflingowi",
    ["halflinke"] = "halflince",
    ["niziolka"] = "niziolkowi",
    ["niziolce"] = "niziolce",
    ["polelfa"] = "polelfowi",
    ["polelfke"] = "polelfce",
    ["gnoma"] = "gnomowi",
    ["gnomke"] = "gnomce",
    ["ogra"] = "ogrowi",
    ["ogrzyce"] = "ogrzycy",
    ["mutanta"] = "mutantowi",
    ["mutantke"] = "mutantce"
}

local szata = function(desc)
    desc = desc:gsub("czarnoodziany zakapturzony", "czarnoodzianego zakapturzonego")
    desc = desc:gsub("czarnoodziany", "czarnoodzianego")
    for k,v in pairs(replace_szata) do
      local new = rex.gsub(desc, "\\b" .. k .. "\\b", v)
      if new ~= desc then
          return new
      end
    end
    return desc
end

function ateam:retrieve_id(id)
    if id ~= nil and tonumber(id) > 100 then
        -- TODO: Maybe find a better way to check whether the number is raw?
        id_retrieved = id
    elseif ateam.enemy_op_ids[tonumber(id)] then
        id_retrieved = ateam.enemy_op_ids[tonumber(id)]
    elseif ateam.normal_ids[tonumber(id)] then
        id_retrieved = ateam.normal_ids[tonumber(id)]
    elseif string.starts(id, "ob") == true then
        id_retrieved = id:gsub("ob_", "")
    end

    if not ateam.objs[id_retrieved].desc:starts("czarnoodzian") then
        id_retrieved = "ob_" .. id_retrieved
    else
        id_retrieved = szata(ateam.objs[id_retrieved].desc)
    end
    

    return id_retrieved
end

function ateam:retrieve_team_id(id)
    local id_retrieved = ateam.team[string.upper(id)]
    
    if not ateam.objs[id_retrieved].desc:starts("czarnoodzian") then
        id_retrieved = "ob_" .. id_retrieved
    else
        id_retrieved = szata(ateam.objs[id_retrieved].desc)
    end

    return id_retrieved
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

    local real_id = ateam:retrieve_id(id)
    if real_id then
        sendAll("przestan kryc sie za zaslona", "przelam obrone " .. real_id, false)
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
            local real_id = ateam:retrieve_team_id(id)
            send("wskaz " .. real_id .. " jako cel obrony", false)
        end
    else
        ateam.clicked_second_defense = false
        if id == "@" then
            send("rozkaz druzynie zaslonic ciebie", false)
        else
            local real_id = ateam:retrieve_team_id(id)
            send("rozkaz druzynie zaslonic  " .. real_id, false)
        end
    end
end

function ateam:rz_func(id)
    if id == "@" then
        sendAll("wskaz siebie jako cel obrony", "rozkaz druzynie zaslonic ciebie", false)
    elseif ateam.team[id] then
        local real_id = ateam:retrieve_team_id(id)
        sendAll("wskaz " .. real_id .. " jako cel obrony", "rozkaz druzynie zaslonic " .. real_id, false)
    else
        scripts:print_log("Nie ma takiego id")
    end
end

function ateam:ra_func(id)
    if ateam.enemy_op_ids[tonumber(id)] then
        local real_id = ateam:retrieve_id(id)
        sendAll("wskaz " .. real_id .. " jako cel ataku", "rozkaz druzynie zaatakowac " .. real_id, false)
    else
        scripts:print_log("Nie ma takiego id")
    end
end

function ateam:rb_func(id)
    if ateam.enemy_op_ids[tonumber(id)] then
        local real_id = ateam:retrieve_id(id)
        send("rozkaz druzynie zablokowac " .. real_id, false)
    else
        scripts:print_log("Nie ma takiego id")
    end
end

function ateam:wz_func(id)
    if id == "@" then
        send("wskaz siebie jako cel obrony", false)
    elseif ateam.team[id] then
        local real_id = ateam:retrieve_team_id(id)
        send("wskaz " .. real_id .. " jako cel obrony", false)
    else
        scripts:print_log("Nie ma takiego id")
    end
end

function ateam:wa_func(id)
    local real_id = ateam:retrieve_id(id)
    if real_id then
        send("wskaz " .. real_id .. " jako cel ataku", false)
    else
        scripts:print_log("Nie ma takiego id")
    end
end

function ateam:w_func(id)
    local real_id = ateam:retrieve_team_id(id)
    if ateam.team[id] then
        send("gzwycofaj sie za " .. real_id, false)
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
                send("ocen " .. ob_desc, false)
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
            send("ocen " .. id, false)
            return
        end

        if id_retrieved then
            local ob_desc = "ob_" .. id_retrieved
            send("ocen " .. ob_desc, false)
        else
            scripts:print_log("Nie ma takiego id")
            return
        end
    end
end

function ateam:por2_func(name)
    if name then
        send("ocen " .. name, false)
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
        for _, person in pairs(results) do
            if table.index_of(scripts.people.enemy_guilds, scripts.people:get_guild_name(person.guild)) then
                scripts:print_log(string.format("%s - cwaniak probuje zaprosic cie do druzyny. Wstyd!", name), true)
                return
            end
        end
    end

    if obj_to_join then
        scripts.utils.bind_functional("porzuc druzyne;dolacz do ob_" .. obj_to_join)
    elseif not self.rebind_timer then
        self.rebind_timer = tempTimer(0.5, function()
             self:bind_joining(name)
             self.rebind_timer = nil
        end)
    end
end

function ateam:give_leader(id)
    local real_id = ateam:retrieve_team_id(id)
    if real_id then
        if real_id:starts("czarnoodzian") then
            real_id = real_id:gsub("czarnoodziany zakapturzony", "czarnoodzianemu zakapturzonemu")
            real_id = real_id:gsub("czarnoodziany", "czarnoodzianemu")
            real_id = real_id:gsub("czarnoodziana zakapturzona", "czarnoodzianej zakapturzonej")
            real_id = real_id:gsub("czarnoodziana", "czarnoodzianej")
            for k,v in pairs(replace_szata_celownik) do
                real_id = rex.gsub(real_id, "\\b" .. k .. "\\b", v)
            end
        end
        sendAll("przekaz prowadzenie " .. real_id, false)
    else
        scripts:print_log("Nie ma takiego id")
    end
end

function ateam:zap_func(id)
    local id = ateam:retrieve_id(id)
    if id then
        send("zapros " .. id, false)
    end
end

function ateam:block_func(id)
    local id_retrieved = ateam:retrieve_id(id)

    if id_retrieved then     
        send("zablokuj " .. id_retrieved, true)
    else
        scripts:print_log("Nie ma takiego id")
    end
end

