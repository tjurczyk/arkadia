function ateam:init_gmcp()
    sendGMCP('Core.Supports.Add ["Objects", "Gmcp_msgs"]')
    ateam:set_base64()
end

function ateam:start_ateam()
    if not scripts:check_gmcp(false) then
        return
    end
    self:init_gmcp()
    scripts:print_log("Skrypty druzynowe wystartowane")
end

function ateam:kk()
    sendGMCP("objects.nums")
    sendGMCP("objects.data")
end

function ateam:set_base64()
    sendGMCP('Core.Options.Set ["base64_gmcp_msgs"]')
end

function ateam:restart_ateam(silent)
    if not scripts:check_gmcp(silent) then
        return
    end

    ateam.objs = {}
    ateam.team = {}
    ateam.team_names = {}
    ateam.team_alphabetical_ids = {}
    ateam.my_id = nil

    if ateam.options.team_numbering_mode == "mode2" then
        ateam.next_team_id = "1"
    else
        ateam.next_team_id = "A"
    end
    ateam.to_support = nil

    
    self:init_gmcp()
    sendGMCP("objects.data")

    if not silent then
        scripts:print_log("Skrypty druzynowe zrestartowane")
    end
end

function ateam:parse_objects_data()
    ateam.only_hp_update = true
    ateam.enemies_on_location_count = 0

    for k, v in pairs(gmcp.objects.data) do
        if v["living"] and not ateam.objs[tonumber(k)] then
            ateam.objs[tonumber(k)] = {}
        end

        if v["avatar"] == true then
            ateam.my_id = tonumber(k)
            ateam.team[ateam.my_id] = "@"
        end

        if ateam.objs[tonumber(k)] then
            for i, j in pairs(v) do
                ateam.objs[tonumber(k)][i] = j
            end
        end
    end

    ateam:collect_people_on_location()
    raiseEvent("gmcp_parsing_finished")
end

function ateam:collect_people_on_location()
    ateam.people_on_location = {}
    if not gmcp.objects.nums then
        gmcp.objects.nums = {}
    end
    for k, v in pairs(gmcp.objects.nums) do
        if ateam.objs[tonumber(v)] then
            table.insert(ateam.people_on_location, ateam.objs[tonumber(v)]["desc"])
        end
    end
end

function ateam:print_status()
    clearUserWindow(scripts.ui.states_window_name)
    clearUserWindow(scripts.ui.enemy_states_window_name)

    if scripts.ui.cfg.states_window_navbar then
        cecho(scripts.ui.states_window_name, "\n  <white>" .. scripts.ui.states_window_navbar_str)
        moveCursorEnd(scripts.ui.states_window_name)
        cecho(scripts.ui.states_window_name, "\n  " .. string.rep("=", getColumnNumber(scripts.ui.states_window_name) - 1) .. "\n")
    end

    -- collect enemies

    -- to keep team_names
    ateam.team_names = {}

    -- enemy_op_ids is for enemy_id -> id (bidirectional)
    ateam.enemy_op_ids = {}

    -- team_enemies list, [team_id] = {_list_of_id 's of enemies}
    -- who is attacked by which enemies
    ateam.team_enemies = {}

    -- who attack which enemy, [enemy_id] = {_script's_list_of_ids_of_teams}
    ateam.attacking_by_team = {}

    -- this is to hold numbers of normal people. Used when 'all_numbering' is set
    ateam.normal_ids = {}

    -- this holds a list of neutral ids. needed in case when neutrals must be added some constant

    local id_start = 1
    local if_msg_support = false
    local if_msg_target = false
    ateam.attack_target = nil
    ateam.defense_target = nil

    local new_is_enemy_on_location = false

    if not gmcp or not gmcp.objects or not gmcp.objects.nums then
        return
    end

    for k, v in pairs(gmcp.objects.nums) do
        if ateam.objs[v] and (ateam.objs[v]["enemy"] == true or ateam.team[ateam.objs[v]["attack_num"]]) then
            -- this is when this is the enemy

            -- give it the id
            ateam.enemy_op_ids[v] = id_start
            ateam.enemy_op_ids[id_start] = v

            -- if necessary create an entry for the team_member
            if not ateam.team_enemies[ateam.objs[v]["attack_num"]] then
                ateam.team_enemies[ateam.objs[v]["attack_num"]] = {}
            end

            -- add this enemy to the id of the teammember (whose he is attacking)
            table.insert(ateam.team_enemies[ateam.objs[v]["attack_num"]], id_start)

            -- next enemy will have next id
            id_start = id_start + 1

            -- if this is target and I'm not attacking it, mark to msg
            if ateam.objs[v]["attack_target"] and ateam.objs[ateam.my_id]["attack_num"] ~= v then
                if_msg_target = true
            end

            -- if this is the target, mark it
            if ateam.objs[v]["attack_target"] then
                ateam.attack_target = v
            end
            new_is_enemy_on_location = true

        elseif (ateam.objs[v] and ateam.objs[v]["team"] == true) or v == ateam.my_id then
            -- this is when this is the team or me

            if not ateam.objs[v]["avatar"] then
                ateam.team_names[ateam.objs[v]["desc"]] = true
            end

            -- if you see a teammate for the first time, add him
            if v ~= ateam.my_id and not ateam.team[v] then
                ateam.team[v] = ateam.next_team_id
                ateam.team[ateam.next_team_id] = v
                --ateam.next_team_id = string.char(string.byte(ateam.next_team_id)+1)
                ateam:increase_team_id_counter()
                ateam.team_names[ateam.objs[v]["desc"]] = true
                if self.killed_by_team_trigger == nil then
                    self.killed_by_team_trigger = tempRegexTrigger("^([a-zA-Z]+) zabil(|a) (.*)\\.$", function() trigger_func_process_kill_for_teammate() end)
                end
                ateam:build_alphabetical_list()
            end

            -- if necessary create an entry for the enemy
            if ateam.objs[v]["attack_num"] and not ateam.attacking_by_team[ateam.objs[v]["attack_num"]] then
                ateam.attacking_by_team[ateam.objs[v]["attack_num"]] = {}
            end

            if ateam.objs[v]["attack_num"] then
                -- add this team member to the id of the enemy (which is he attacking)
                table.insert(ateam.attacking_by_team[ateam.objs[v]["attack_num"]], ateam.team[v])
            end

            -- if this is the defense target, mark it
            if ateam.objs[v]["defense_target"] then
                ateam.defense_target = v
            end

        elseif ateam.all_numbering then
            ateam.normal_ids[v] = id_start
            ateam.normal_ids[id_start] = v

            -- next enemy will have next id
            id_start = id_start + 1
        end

        if ateam.objs[v] and ateam.objs[v]["team_leader"] == true and ateam.objs[v]["attack_num"] ~= false and ateam.objs[v]["attack_num"] ~= ateam.objs[ateam.my_id]["attack_num"] then
            -- if you see the team_leader and it is attacking different than me, mark to msg
            if_msg_support = v
        end
    end

    if new_is_enemy_on_location then
        for k, v in pairs(ateam.normal_ids) do
            if k < 50 then
                local new_k = k + 50
                ateam.normal_ids[new_k] = v
                ateam.normal_ids[v] = new_k
                ateam.normal_ids[k] = nil
            end
        end
    end

    if ateam.is_enemy_on_location == true and new_is_enemy_on_location == false then
        -- event that all enemies are killed
        raiseEvent("ateam_all_enemies_killed")
    end

    ateam.is_enemy_on_location = new_is_enemy_on_location

    if if_msg_target then
        ateam:msg_attack_target()
    elseif if_msg_support then
        ateam:msg_support(if_msg_support)
    end

    -- print me first
    ateam:print_obj_team(ateam.my_id, ateam.objs[ateam.my_id])

    -- print the team
    if ateam.options.alphabetical_sort_team then
        for _, v in pairs(ateam.team_alphabetical_ids) do
            if v ~= ateam.my_id and table.contains(gmcp.objects.nums, v) and ateam.objs[v]["team"] then
                ateam:print_obj_team(v, ateam.objs[v])
            end
        end
    else
        for k, v in pairs(gmcp.objects.nums) do
            if v ~= ateam.my_id and ateam.objs[v] and ateam.objs[v]["team"] == true then
                ateam:print_obj_team(v, ateam.objs[v])
            end
        end
    end

    -- print enemies
    for k, v in pairs(gmcp.objects.nums) do
        if v ~= ateam.my_id and ateam.enemy_op_ids[v] then
            ateam:print_obj_enemy(v, ateam.objs[v])
        end
    end

    -- print others
    for k, v in pairs(gmcp.objects.nums) do
        if v ~= ateam.my_id and not ateam.enemy_op_ids[v] and ateam.objs[v] and ateam.objs[v]["team"] == false then
            ateam:print_obj_normal(v, ateam.objs[v])
        end
    end

    -- EXPERIMENTAL
    -- if fighting is different than the previous one
    -- and the prev is the attack target, bind breaking
    --if ateam.prev_enemy and ateam.objs[ateam.my_id]["attack_num"] and
    --   ateam.prev_enemy ~= ateam.objs[ateam.my_id]["attack_num"] and
    --   ateam.objs[ateam.prev_enemy]["attack_target"] == true then

    --  for k, v in pairs(gmcp.objects.nums) do
    --    if v == ateam.prev_enemy then
    --      ateam:msg_break_defense(ateam.prev_enemy)
    --      break
    --    end
    --  end
    --end

    -- set prev as the current one
    if ateam.my_id and ateam.objs[ateam.my_id] then
        ateam.prev_enemy = ateam.objs[ateam.my_id]["attack_num"]
    end

    raiseEvent("printStatusDone")

end

function ateam:print_obj_team(id, obj)
    --
    -- id - id of object. for example '30000'. it's the id from Arkadia
    -- obj - dictionary of object
    --

    if obj then
        -- mark it as current target if necessary
        if obj["defense_target"] == true then
            ateam.current_defense_target = id
            ateam.current_defense_target_relative = ateam.team[id]
        end

        local str_id = " @"

        if ateam.team[id] then
            str_id = string.sub(" " .. ateam.team[id], 1, 3)
        end

        -- special section
        if obj["defense_target"] == true then
            cecho(scripts.ui.states_window_name, "<green:team_console_bg>>>")

            moveCursorEnd(scripts.ui.states_window_name)
            local a = selectString(scripts.ui.states_window_name, ">>", 1)

            if ateam.team[id] then
                setLink(scripts.ui.states_window_name, [[ateam:rz_func("]] .. ateam.team[id] .. [[")]], "rozkaz zaslonic " .. ateam.team[id])
                deselect(scripts.ui.states_window_name)
            end
        else
            cecho(scripts.ui.states_window_name, "<white:team_console_bg>  ")
            moveCursorEnd(scripts.ui.states_window_name)
            local a = selectString(scripts.ui.states_window_name, "  ", 1)

            if ateam.team[id] then
                setLink(scripts.ui.states_window_name, [[ateam:wz_func("]] .. ateam.team[id] .. [[")]], "wskaz " .. ateam.team[id] .. " jako cel obrony")
                deselect(scripts.ui.states_window_name)
            end
        end

        -- id section
        if ateam.broken_defense_names[obj["desc"]] then
            cecho(scripts.ui.states_window_name, "<" .. ateam.options.broken_defense_fg_color .. ":" .. ateam.options.broken_defense_bg_color .. ">[" .. str_id .. "]")
        else
            cecho(scripts.ui.states_window_name, "<white:team_console_bg>[" .. str_id .. "<white:team_console_bg>]")
        end

        -- sneaky id section
        if ateam.sneaky_attack > 0 then
            cecho(scripts.ui.states_window_name, "<white:team_console_bg>[  ]")
        end

        -- hp section
        cecho(scripts.ui.states_window_name, "<white:team_console_bg>[" .. states[obj["hp"]] .. "<grey:team_console_bg><white:team_console_bg>] ")

        if str_id ~= " @" then
            local hp_to_select = string.split(states[obj["hp"]], ">")[2]
            local a = selectString(scripts.ui.states_window_name, hp_to_select, 1)
            setLink(scripts.ui.states_window_name, [[ateam:w_func("]] .. ateam.team[id] .. [[")]], "gzwycofaj sie za " .. str_id)
            deselect(scripts.ui.states_window_name)
        end

        -- name section
        local str_name = "JA"
        local str_name_original = obj["desc"]
        if str_id ~= " @" then
            str_name = str_name_original
        end

        if ateam.paralyzed_names[obj["desc"]] then
            cecho(scripts.ui.states_window_name, "<" .. ateam.options.team_mate_stun_fg_color .. ":" .. ateam.options.team_mate_stun_bg_color .. ">" .. str_name .. " ")
        elseif str_name ~= "JA" then
            cecho(scripts.ui.states_window_name, "<LimeGreen:team_console_bg>" .. str_name .. " ")
        else
            cecho(scripts.ui.states_window_name, "<white:team_console_bg>" .. str_name .. " ")
        end

        -- zas section
        local zas_str = nil
        if ateam.team_enemies[id] then
            zas_str = "  <- [" .. table.concat(ateam.team_enemies[id], ",") .. "]"
            cecho(scripts.ui.states_window_name, "<white:team_console_bg>" .. zas_str)
        elseif not table.is_empty(ateam.team_enemies) and not obj.attack_num then
            cecho(scripts.ui.states_window_name, "  <red:team_console_bg>X<reset>")
        end

        if str_name ~= "JA" and ateam.team[id] then
            local a = selectString(scripts.ui.states_window_name, str_name_original, 1)

            setLink(scripts.ui.states_window_name, [[ateam:za_func("]] .. ateam.team[id] .. [[")]], "zaslon " .. str_name_original)
            deselect(scripts.ui.states_window_name)
        end

        cecho(scripts.ui.states_window_name, "\n")
        moveCursorEnd(scripts.ui.states_window_name)
    end
end

function ateam:print_obj_enemy(id, obj)
    --
    -- id - id of object. for example '30000'. it's the id from Arkadia
    -- obj - dictionary of object
    --

    if obj then
        -- mark it as current target if necessary
        if obj["attack_target"] == true then
            ateam.current_attack_target = id
            ateam.current_attack_target_relative = ateam.enemy_op_ids[id]
        end

        local print_id = ateam.enemy_op_ids[id]
        local str_id = "  "

        if tonumber(print_id) > 9 then
            str_id = print_id
        else
            str_id = " " .. print_id
        end

        -- special section
        if obj["attack_target"] == true then
            cecho(scripts.ui.enemy_states_window_name, "<red:team_console_bg>>>")

            moveCursorEnd(scripts.ui.enemy_states_window_name)
            local a = selectString(scripts.ui.enemy_states_window_name, ">>", 1)

            setLink(scripts.ui.enemy_states_window_name, [[ateam:ra_func("]] .. ateam.enemy_op_ids[id] .. [[")]], "rozkaz zaatakowac " .. ateam.enemy_op_ids[id])
            deselect(scripts.ui.enemy_states_window_name)
        else
            cecho(scripts.ui.enemy_states_window_name, "<white:team_console_bg>  ")

            moveCursorEnd(scripts.ui.enemy_states_window_name)
            local a = selectString(scripts.ui.enemy_states_window_name, "  ", 1)

            setLink(scripts.ui.enemy_states_window_name, [[ateam:wa_func("]] .. ateam.enemy_op_ids[id] .. [[")]], "wskaz " .. ateam.enemy_op_ids[id] .. " jako cel ataku")
            deselect(scripts.ui.enemy_states_window_name)
        end

        -- id section
        if ateam.broken_defense_names[obj["desc"]] then
            cecho(scripts.ui.enemy_states_window_name, "<" .. ateam.options.broken_defense_fg_color .. ":" .. ateam.options.broken_defense_bg_color .. ">[" .. str_id .. "]")
        else
            local color = "white"
            if id == ateam.next_attack_objs.next_attak_obj and ateam.next_attack_objs.mark_in_state then
                color = "orange"
            end
            cecho(scripts.ui.enemy_states_window_name, string.format("<white:team_console_bg>[<%s>%s<white>]<reset>", color, str_id))
        end

        -- sneaky id section
        if ateam.sneaky_attack > 0 then
            cecho(scripts.ui.enemy_states_window_name, "<white:team_console_bg>[  ]")
        end

        -- hp section
        cecho(scripts.ui.enemy_states_window_name, "<white:team_console_bg>[" .. states[obj["hp"]] .. "<grey:team_console_bg>] ")

        if print_id then
            selectString(scripts.ui.enemy_states_window_name, states_no_color[obj["hp"]], 1)
            setLink(scripts.ui.enemy_states_window_name, [[ ateam:prze_func("]] .. ateam.enemy_op_ids[id] .. [[", true) ]], "przelam obrone " .. ateam.enemy_op_ids[id])
            deselect(scripts.ui.enemy_states_window_name)
        end

        -- name section
        local str_name = obj["desc"]

        -- coloring for enemy desc
        local is_enemy = false
        if ateam.objs[ateam.my_id]["attack_num"] == id then
            if ateam.paralyzed_names[obj["desc"]] then
                cecho(scripts.ui.enemy_states_window_name, "<" .. ateam.options.enemy_stun_fg_color .. ":" .. ateam.options.enemy_stun_bg_color .. ">" .. str_name)
            else
                cecho(scripts.ui.enemy_states_window_name, "<red:team_console_bg>" .. str_name)
            end

            is_enemy = true
        elseif obj["enemy"] == true or ateam.team[obj["attack_num"]] then
            if ateam.paralyzed_names[obj["desc"]] then
                cecho(scripts.ui.enemy_states_window_name, "<" .. ateam.options.enemy_stun_fg_color .. ":" .. ateam.options.enemy_stun_bg_color .. ">" .. str_name)
            else
                cecho(scripts.ui.enemy_states_window_name, "<dark_violet:team_console_bg>" .. str_name)
            end

            is_enemy = true
        else
            if ateam.paralyzed_names[obj["desc"]] then
                cecho(scripts.ui.enemy_states_window_name, "<" .. ateam.options.enemy_stun_fg_color .. ":" .. ateam.options.enemy_stun_bg_color .. ">" .. str_name)
            else
                cecho(scripts.ui.enemy_states_window_name, "<white:team_console_bg>" .. str_name)
            end
        end

        -- if is the part of the fight then set zas2 link
        if is_enemy then
            selectString(scripts.ui.enemy_states_window_name, str_name, 1)
            setLink(scripts.ui.enemy_states_window_name, [[ ateam:zas_func("]] .. ateam.enemy_op_ids[id] .. [[") ]], "zaslon przed " .. ateam.enemy_op_ids[id])
            deselect(scripts.ui.enemy_states_window_name)
        end

        -- attacking by whom section
        if table.size(ateam.attacking_by_team[id]) > 0 then
            by_whom_str = "  -> [" .. table.concat(ateam.attacking_by_team[id], ",") .. "]   "
            cecho(scripts.ui.enemy_states_window_name, "<white:team_console_bg>" .. by_whom_str)
        end

        -- if is the part of the fight then set zab link
        if print_id then
            selectString(scripts.ui.enemy_states_window_name, print_id, 1)
            setLink(scripts.ui.enemy_states_window_name, [[ ateam:zab_func(" ]] .. ateam.enemy_op_ids[id] .. [[") ]], "zabij " .. ateam.enemy_op_ids[id])
            deselect(scripts.ui.enemy_states_window_name)
        end

        cecho(scripts.ui.enemy_states_window_name, "\n")
        moveCursorEnd(scripts.ui.enemy_states_window_name)
    end
end

function ateam:print_obj_normal(id, obj)
    --
    -- id - id of object. for example '30000'. it's the id from Arkadia
    -- obj - dictionary of object
    --

    if obj then
        local print_id = ateam.normal_ids[id]
        local str_id = "  "

        if not print_id then
            str_id = "  "
        elseif tonumber(print_id) > 9 then
            str_id = print_id
        else
            str_id = " " .. print_id
        end

        cecho(scripts.ui.enemy_states_window_name, "<white:team_console_bg>  ")

        moveCursorEnd(scripts.ui.enemy_states_window_name)
        local a = selectString(scripts.ui.enemy_states_window_name, "  ", 1)

        setLink(scripts.ui.enemy_states_window_name, [[ateam:por_func("ob_]] .. id .. [[")]], "porownaj sie z " .. obj["desc"])
        deselect(scripts.ui.enemy_states_window_name)

        -- id section
        local color = "white"
        if id == ateam.next_attack_objs.next_attak_obj and ateam.next_attack_objs.mark_in_state then
            color = "orange"
        end
        cecho(scripts.ui.enemy_states_window_name, string.format("<white:team_console_bg>[<%s>%s<white>]<reset>", color, str_id))

        -- sneaky id section
        if ateam.sneaky_attack > 0 then
            if ateam.sneaky_attack > 1 or ateam:can_perform_sneaky_attack() then
                cecho(scripts.ui.enemy_states_window_name, "<white:team_console_bg>[<sky_blue:team_console_bg>xx<white:team_console_bg>]")
                selectString(scripts.ui.enemy_states_window_name, "xx", 1)
                setLink(scripts.ui.enemy_states_window_name, [[ ateam:sneaky_zab_func("]] .. id .. [[") ]], "zaskocz " .. obj["desc"])
                deselect(scripts.ui.enemy_states_window_name)
            else
                cecho(scripts.ui.enemy_states_window_name, "<white:team_console_bg>[  ]")
            end
        end

        -- hp section
        cecho(scripts.ui.enemy_states_window_name, "<white:team_console_bg>[" .. states[obj["hp"]] .. "<white:team_console_bg>] ")

        -- name section
        local str_name = obj["desc"]

        -- set color for desc
        cecho(scripts.ui.enemy_states_window_name, "<white:team_console_bg>" .. str_name)

        -- if print_id not nil (numbering normals) then set zab function on it
        if print_id then
            selectString(scripts.ui.enemy_states_window_name, print_id, 1)
            setLink(scripts.ui.enemy_states_window_name, [[ ateam:zab_func(" ]] .. ateam.normal_ids[id] .. [[") ]], "zabij " .. ateam.normal_ids[id])
            deselect(scripts.ui.enemy_states_window_name)
        end

        cecho(scripts.ui.enemy_states_window_name, "\n")
        moveCursorEnd(scripts.ui.enemy_states_window_name)
    end
end

function ateam:msg_support(v)
    raiseEvent("ateamAttackingDifferentTarget")
    if ateam.can_msg then
        ateam.can_msg = false
        ateam.to_support = v
        scripts.messages:warning("Bijesz innego: " .. scripts.keybind:keybind_tostring("fight_support"))
        tempTimer(3, [[ ateam.can_msg = true ]])
    end
end

function ateam:msg_attack_target()
    raiseEvent("ateamToAttackTarget")
    if ateam.can_msg then
        ateam.can_msg = false
        scripts.messages:warning("Zaatakuj wskazany cel: " .. scripts.keybind:keybind_tostring("attack_target"))
        tempTimer(3, [[ ateam.can_msg = true ]])
    end
end

function ateam:msg_break_defense(to_break_enemy)
    ateam.can_msg = false
    scripts.messages:warning("PRZELAM obrone: " .. scripts.keybind:keybind_tostring("attack_bind_obj"))
    ateam.break_enemy_defense_id = to_break_enemy
end

function ateam:switch_releasing_guards()
    if ateam.release_guards then
        ateam.release_guards = false
        scripts:print_log("Ok, nie bede puszczal zaslon")
    else
        ateam.release_guards = true
        scripts:print_log("Ok, bede puszczal zaslony")
    end
    raiseEvent("switchReleasigGuards", ateam.release_guards)
end

function ateam:build_alphabetical_list()
    local ateam_local_ids = {}
    ateam.team_alphabetical_ids = {}
    -- assume the max id we can get in team is 99
    for k in pairs(ateam.team) do
        if type(k) == "string" or k < 100 then
            table.insert(ateam_local_ids, k)
        end
    end

    table.sort(ateam_local_ids)
    for _, v in pairs(ateam_local_ids) do
        table.insert(ateam.team_alphabetical_ids, ateam.team[v])
    end
end
