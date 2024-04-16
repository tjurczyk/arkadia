local standard_lost_follows = table.concat({
    "w szara mgle",
    "w lesna gestwine"
}, "|")

function amap:follow(direction, is_team_follow)
    -- `direction' - passed direction, either from key or team follow
    -- `is_team_follow' true if called from team follow

    -- immediately clear next dir bind
    amap.next_dir_bind = nil

    -- store current_id, can be necessary later
    local current_id = amap.curr.id

    -- retrieve the dir first
    -- the direction can be passed as a parameter, then use it
    local dir = nil
    if amap.short_to_long[direction] then
        dir = amap.short_to_long[direction]
    else
        dir = direction
    end

    -- try to get a new room id from the dir
    local new_id = get_next_room_from_dirs(current_id, dir, dir, is_team_follow)

    -- if found, proceed
    if new_id then
        amap.curr.id = new_id
        local curr_area = getRoomArea(amap.curr.id)
        amap.curr.area = getRoomAreaName(curr_area)

        amap.curr.x, amap.curr.y, amap.curr.z = getRoomCoordinates(amap.curr.id)
        amap.curr.exits = {}
        for en_long_dir, _ in pairs(getRoomExits(amap.curr.id)) do
            amap.curr.exits[amap.long_to_short[en_long_dir]] = true
        end
        amap.curr.y = -amap.curr.y
        amap:may_prepare_next_go_dir()
        centerview(amap.curr.id)
        if not is_team_follow then
            raiseEvent("amapWalking", direction)
        end
        raiseEvent("amapNewLocation", amap.curr.id, direction)
        amap:copy_loc(amap.prev, amap.curr)
        return true
    else
        return false
    end
end

function amap:locate(noprint, skip_db)
    amap.history = get_new_list()
    local tmp_loc = amap:extract_gmcp()

    local msg = nil
    local ret = false

    -- immediately clear next dir bind
    amap.next_dir_bind = nil

    if tmp_loc.x then
        local curr_id = not amap.legacy_locate and amap:get_room_by_hash(tmp_loc.x, tmp_loc.y, tmp_loc.z, tmp_loc.area) or
            amap:room_exist(tmp_loc.x, tmp_loc.y, tmp_loc.z, tmp_loc.area)
        if curr_id and curr_id > 0 then
            amap.curr.id = curr_id
            amap.curr.x = tmp_loc.x
            amap.curr.y = tmp_loc.y
            amap.curr.z = tmp_loc.z
            amap.curr.area = tmp_loc.area
            amap:copy_loc(amap.prev, amap.curr)
            centerview(curr_id)
            raiseEvent("amapNewLocation", amap.curr.id)
            amap_ui_set_dirs_trigger(getRoomExits(amap.curr.id))
            amap:follow_mode()
            msg = "Ok, jestes zlokalizowany po GMCP"
            ret = true
        else
            msg =
            "Nie moge Cie zlokalizowac na podstawie tych koordynatow (prawdopodobnie lokacja z tymi koordynatami nie istnieje)"
        end
    else
        if not skip_db and amap.localization:try_to_locate() then
            msg = "Zlokalizowalem po opisie lokacji i wyjsciach."
            ret = true
        else
            msg = "GMCP nie zawiera koordynatow, nie moge cie zlokalizowac na mapie"
        end
    end

    if not noprint then
        amap:print_log(msg)
    end
    return ret
end

function amap:locate_on_next_location(skip_db)
    registerAnonymousEventHandler("gmcp.room.info", function()
        amap:locate(true, skip_db)
    end, true)
end

function amap:set_position(room_id, silent)
    -- immediately clear next dir bind
    amap.next_dir_bind = nil

    if getRoomExits(room_id) then
        amap.curr.id = room_id
        amap.curr.x, amap.curr.y, amap.curr.z = getRoomCoordinates(amap.curr.id)
        amap.curr.y = -amap.curr.y
        local curr_area = getRoomArea(amap.curr.id)
        amap.curr.area = getRoomAreaName(curr_area)
        if gmcp and gmcp.room and gmcp.room.info and gmcp.room.info.exits then
            amap.curr.exits = gmcp.room.info.exits
        end
        centerview(amap.curr.id)
        amap:copy_loc(amap.prev, amap.curr)

        if not silent then
            amap:print_log("Pozycja ustawiona")
        end

        amap.history = get_new_list()
        amap_add_location_history()
        amap_ui_set_dirs_trigger(getRoomExits(amap.curr.id))

        raiseEvent("setPosition", amap.curr.id)
        raiseEvent("amapNewLocation", amap.curr.id)
    else
        if not silent then
            amap:print_log("Lokacja z tym ID nie istnieje")
        end
    end
end

function amap:generate_hash(x, y, z, area_name)
    return string.format("%s:%s:%s:%s", x, y, z, area_name)
end

function get_next_room_from_dirs(room_id, dir, spe, is_team_follow)
    if not room_id then
        return nil
    end

    local all_exits = getRoomExits(room_id)
    local normal_exit = all_exits[dir]
    local all_special_exits = getSpecialExitsSwap(room_id)
    local special_exit = all_special_exits[spe]

    local new_id = nil

    if normal_exit then
        new_id = normal_exit
    elseif special_exit then
        new_id = special_exit
    end

    -- if there still isn't a new_id and team_member is true (following), check team follow links
    if not new_id and is_team_follow then
        follow_dict = amap.db:separate_follow_links(room_id)
        for k, v in pairs(follow_dict) do
            if string.find(spe, k) then
                -- found, get room_id from it
                local normal_exit = all_exits[amap.short_to_long[v]]
                local special_exit = all_special_exits[v]

                if normal_exit then
                    new_id = normal_exit
                elseif special_exit then
                    new_id = special_exit
                end

                if new_id then
                    -- only if found new_id break, otherwise continue checking
                    break
                end
            end
        end

        -- if still nothing, see if any of words match the exact exit
        if new_id then
            return new_id
        elseif is_team_follow and all_special_exits then
            for k, v in pairs(all_special_exits) do
                if string.find(spe, k) then
                    -- found a special exit that is in the follow string, return it
                    --echo ("Returning 100% rule string: " .. k)
                    new_id = v
                    break
                end
            end
        end

        -- if still nothing, try to do fuzzy matching on 70% of special exit
        if new_id then
            return new_id
        elseif is_team_follow and all_special_exits then
            for k, v in pairs(all_special_exits) do
                local k_limited = string.sub(k, 0, math_round(0.7 * #k))
                if string.find(spe, k_limited) then
                    -- found a special exit that is 70% partially in the follow string, return it
                    --echo ("Returning 70% rule string: " .. k_limited)
                    new_id = v
                    break
                end
            end
        end
    end

    if is_team_follow and not new_id then
        amap:locate(true)
        amap:locate_on_next_location()
        if not rex.match(spe, "(?:" .. standard_lost_follows .. ")$") then
            amap:log_failed_follow("[" ..
                getTime(true, "yyyy/MM/dd HH:mm:ss") ..
                "]: mapper zgubiony. last curr.id: " .. tostring(amap.curr.id) .. ", spe: `" .. spe .. "`\n")
        end
    end

    return new_id
end

function amap:init_self_locating(skip_db)
    amap.locate_handler = scripts.event_register:force_register_event_handler(amap.locate_handler, "gmcp.room.info",
        function()
            if amap:locate(true, skip_db) then
                scripts.event_register:kill_event_handler(amap.locate_handler)
            end
        end)
    amap.set_position_handler = scripts.event_register:force_register_event_handler(amap.set_position_handler,
        "setPosition", function()
            scripts.event_register:kill_event_handler(amap.locate_handler)
        end, true)
end

function amap:check_direction_coords_correctness(c_x, c_y, c_z, x, y, z, dir)
    -- c_x, c_y, c_z - coords of current location
    -- x, y, z - coords of checking location
    local short_dir = amap.long_to_short[dir]

    if short_dir == "s" then
        if x == c_x and y > c_y and z == c_z then
            return true
        else
            return false
        end
    elseif short_dir == "n" then
        if x == c_x and y < c_y and z == c_z then
            return true
        else
            return false
        end
    elseif short_dir == "e" then
        if x > c_x and y == c_y and z == c_z then
            return true
        else
            return false
        end
    elseif short_dir == "w" then
        if x < c_x and y == c_y and z == c_z then
            return true
        else
            return false
        end
    elseif short_dir == "nw" then
        if x < c_x and y < c_y and z == c_z then
            return true
        else
            return false
        end
    elseif short_dir == "ne" then
        if x > c_x and y < c_y and z == c_z then
            return true
        else
            return false
        end
    elseif short_dir == "sw" then
        if x < c_x and y > c_y and z == c_z then
            return true
        else
            return false
        end
    elseif short_dir == "se" then
        if x > c_x and y > c_y and z == c_z then
            return true
        else
            return false
        end
    elseif short_dir == "d" then
        if x == c_x and y == c_y and z < c_z then
            return true
        else
            return false
        end
    elseif short_dir == "u" then
        if x == c_x and y == c_y and z > c_z then
            return true
        else
            return false
        end
    end

    return false
end

function amap:check_room_on_direction_of(room, dir, force)
    -- if force is true, no translations/binds are done

    if not amap or not amap.curr or not amap.curr.id then
        return nil
    end

    local n_exits = getRoomExits(amap.curr.id)
    -- Check dir binds
    local user_data = getRoomUserData(amap.curr.id, "dir_bind")
    if user_data ~= "" and not force then
        d_dict = scripts.utils:deserialize_dir_bind(user_data)
        if d_dict[dir] then
            local cmds = string.split(d_dict[dir], "#")
            local was_regular = false

            for k, v in pairs(cmds) do
                if not string.starts(v, "echo") then
                    if amap.short_to_long[v] then
                        was_regular = true
                        amap.dir_from_key = amap.short_to_long[v]
                    end
                    send(v, true)
                else
                    local msg_txt = string.sub(v, 6)
                    cecho(msg_txt .. "\n")
                end
            end

            if was_regular then
                -- run this only if there was a regular move
                amap:on_key_event()
            end
            return true
        end
    end

    local spe_ex = getSpecialExitsSwap(amap.curr.id)
    if spe_ex then
        for k, v in pairs(spe_ex) do
            local to_check_x, to_check_y, to_check_z = getRoomCoordinates(v)
            to_check_y = -to_check_y
            if not force and amap:check_direction_coords_correctness(amap.curr.x, amap.curr.y, amap.curr.z, to_check_x, to_check_y, to_check_z, dir)
                and not n_exits[dir] then
                if not k:starts("script:") then
                    send(k)
                else
                    local cmd = k:gsub("script:", "")
                    loadstring(cmd)()
                end
                return true
            end
        end
    end

    -- check up and down
    if not force and n_exits and n_exits["up"] and not n_exits[dir] then
        local to_check_x, to_check_y, to_check_z = getRoomCoordinates(n_exits["up"])
        to_check_y = -to_check_y
        if amap:check_direction_coords_correctness(amap.curr.x, amap.curr.y, amap.curr.z, to_check_x, to_check_y, to_check_z, dir) then
            amap.dir_from_key = "up"
            amap:pre_on_key_event()
            return true
        end
    end

    if not force and n_exits and n_exits["down"] and not n_exits[dir] then
        local to_check_x, to_check_y, to_check_z = getRoomCoordinates(n_exits["down"])
        to_check_y = -to_check_y
        if amap:check_direction_coords_correctness(amap.curr.x, amap.curr.y, amap.curr.z, to_check_x, to_check_y, to_check_z, dir) then
            amap.dir_from_key = "down"
            amap:pre_on_key_event()
            return true
        end
    end
    return false
end

function amap:manual_go()
    -- this is when 'idz' is used

    if amap.curr and amap.curr.id then
        local curr_id = amap.curr.id
        local prev_id = List.peek_second_to_last(amap.history)
        local exits = getRoomExits(amap.curr.id)

        if table.size(exits) == 2 then
            for k, v in pairs(exits) do
                if v ~= prev_id then
                    return k
                end
            end
            return false
        end
    end

    return false
end

function amap:gate_keybind_pressed()
    send(amap.gate_bind, true)
end

function amap:show_path(dst)
    local path = getPath(amap.curr.id, dst)
    if path then
        amap:print_log("sciezka: " .. table.concat(speedWalkDir, ", "))
    else
        amap:print_log("sciezka nie istnieje")
    end
end

function amap:get_path(dst)
    local path = getPath(amap.curr.id, dst)
    if path then
        return speedWalkDir
    else
        return nil
    end
end

function amap:cancel_highlight()
    for i = 1, table.size(speedWalkPath) do
        unHighlightRoom(tonumber(speedWalkPath[i]))
    end
end

function amap:do_highlight(to_room_number)
    local path = getPath(amap.curr.id, to_room_number)

    for i = 1, table.size(speedWalkPath) do
        highlightRoom(tonumber(speedWalkPath[i]), 0, 130, 130, 200, 200, 200, 1, 255, 255)
    end
    cecho("Odleglosc: " .. table.size(speedWalkPath) .. "\n")
    tempTimer(2, function() amap:cancel_highlight() end)
end

function alias_func_mapper_map_draw_map()
    if matches[2] == "draw" then
        amap:draw_mode_manual()
        amap:print_log("Rysowanie po chodzeniu wlaczone")
    elseif matches[2] == "follow" then
        amap:follow_mode()
        amap:print_log("Tryb sledzenia wlaczony")
    elseif matches[2] == "off" then
        amap:mapper_off()
        amap:print_log("Tryb sledzenia wylaczony")
    else
        amap:print_log("Nieznana opcja, dostepne: draw/follow/off")
    end
end

function alias_func_mapper_map_locate_me()
    amap:locate()
end

function alias_func_mapper_map_show_current_room()
    amap:print_room_info()
end

function alias_func_mapper_map_show_room_id()
    amap:print_room_info(matches[2])
end

function alias_func_mapper_map_set_position()
    amap:set_position(tonumber(matches[2]))
end

function alias_func_mapper_map_go_to_shortcut()
    amap:speedwalk_from_shortcut(matches[2])
end

function alias_func_mapper_map_go_to_shortcut_delay()
    amap:speedwalk_from_shortcut(matches[2], matches[3])
end

function alias_func_mapper_map_go_to_id()
    amap:speedwalk_from_id(tonumber(matches[2]))
end

function alias_func_mapper_map_go_to_id_delay()
    amap:speedwalk_from_id(tonumber(matches[2]), matches[3])
end

function alias_func_mapper_map_go_continue()
    amap:continue_speedwalk()
end

function alias_func_mapper_map_go_continue_delay()
    amap.walker_delay = tonumber(matches[2])
    amap:continue_speedwalk()
end

function alias_func_mapper_map_highlight_path()
    amap:do_highlight(tonumber(matches[2]))
end

function trigger_func_locate_on_next()
    amap:init_self_locating()
end
