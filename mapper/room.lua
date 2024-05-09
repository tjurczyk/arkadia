function amap:add_room_manual()
    amap:copy_loc(amap.prev, amap.curr)

    -- try to retrieve a direction
    local dir = amap:retrieve_dir()
    local new_id = get_next_room_from_dirs(amap.prev.id, dir, command)

    -- if new_id != nil then it already exists
    if new_id then
        amap:set_position(new_id, true)
    else
        amap.curr.x, amap.curr.y, amap.curr.z = amap:get_new_coords(amap.prev.x, amap.prev.y, amap.prev.z, dir)
        amap.curr.area = amap.prev.area

        local area_id = amap:get_area_id(amap.curr.area)
        local room_exist_id = amap:room_exist(amap.curr.x, amap.curr.y, amap.curr.z, amap.curr.area)

        -- create only if the room doesn't exist
        if room_exist_id == 0 then
            amap.curr.id = amap:create_room("", "", amap.curr.x, amap.curr.y, amap.curr.z, area_id, nil)
        else
            amap.curr.id = room_exist_id
        end

        -- link and create stubs
        amap:link_rooms(amap.prev.id, amap.curr.id, dir)
    end

    centerview(amap.curr.id)
    raiseEvent("amapNewLocation", amap.curr.id, dir)

    amap:copy_loc(amap.backup_loc, amap.prev)
    amap:copy_loc(amap.prev, amap.curr)

    amap.dir_from_key = nil
    amap:print_log("Ruch sprawdzony, mozesz isc dalej")
end

function amap:add_location_located_on(dir, located_on)
    if amap.mode ~= "off" and amap.mode ~= "follow" then
        local new_x = nil
        local new_y = nil
        local new_z = nil

        if located_on then
            new_x, new_y, new_z = amap:get_new_coords(amap.curr.x, amap.curr.y, amap.curr.z,
                amap.short_to_long[located_on])
        else
            new_x, new_y, new_z = amap:get_new_coords(amap.curr.x, amap.curr.y, amap.curr.z, amap.short_to_long[dir])
        end

        local area_id = amap:get_area_id(amap.curr.area)

        local room_exist_id = amap:room_exist(new_x, new_y, new_z, amap.curr.area)
        local created_room_id = nil
        if room_exist_id == 0 then
            created_room_id = amap:create_room("", "", new_x, new_y, new_z, area_id, nil)
        else
            amap:print_log("Lokacja juz istnieje w tym kierunku")
            return
        end

        if not setExit(amap.curr.id, created_room_id, dir) then
            amap:print_log("Cos poszlo nie tak...")
        end

        centerview(amap.curr.id)
        amap:print_log("Lokacja stworzona i zlinkowana")
        return created_room_id
    else
        amap:print_log("Dostepne tylko w opcji rysowania")
    end
end

function amap:add_exit(to_room_id, dir)
    if amap.mode ~= "off" and amap.mode ~= "follow" then
        if setExit(amap.curr.id, to_room_id, dir) then
            amap:print_log("Lokacje polaczone")
        else
            amap:print_log("Cos poszlo nie tak...")
        end
    else
        amap:print_log("Dostepne tylko w opcji rysowania")
    end
end

function amap:add_exit_from(from_room_id, to_room_id, dir)
    if amap.mode ~= "off" and amap.mode ~= "follow" then
        if setExit(from_room_id, to_room_id, dir) then
            amap:print_log("Lokacje polaczone")
        else
            amap:print_log("Cos poszlo nie tak...")
        end
    else
        amap:print_log("Dostepne tylko w opcji rysowania")
    end
end

function amap:add_room_special_exit(dir, exit)
    if amap.mode ~= "off" and amap.mode ~= "follow" then
        local x, y, z = amap:get_new_coords(amap.curr.x, amap.curr.y, amap.curr.z, amap.short_to_long[dir])
        local area_id = amap:get_area_id(amap.curr.area)
        local room_id = amap:create_room("", "", x, y, z, area_id, nil)

        addSpecialExit(amap.curr.id, room_id, exit)

        centerview(amap.curr.id)
        amap:print_log("Lokacja stworzona i zlinkowana")
    else
        amap:print_log("Dostepne tylko w opcji rysowania")
    end
end

function amap:add_special_exit(to_room_id, exit)
    if amap.mode ~= "off" and amap.mode ~= "follow" then
        addSpecialExit(amap.curr.id, tonumber(to_room_id), exit)

        centerview(amap.curr.id)
        amap:print_log("Lokacje zlinkowane")
    else
        amap:print_log("Dostepne tylko w opcji rysowania")
    end
end

function amap:create_room(room_name, room_desc, room_x, room_y, room_z, area_id, exits)
    ---
    --- adds a new room and returns its id.
    ---

    local room_id = createRoomID()

    if not addRoom(room_id) then
        amap:print_log("Cos poszlo nie tak...")
        return
    end

    setRoomCoordinates(room_id, room_x, -room_y, room_z)
    setRoomArea(room_id, area_id)
    setRoomName(room_id, room_id)
    amap.created_room = true

    return room_id
end

function amap.change_room_area(area_name)
    if not amap.curr then
        amap:print_log("Nie mam aktualnej lokacji, sproboj sie gdzies zlokalizowac poprzez '/zlok' i wroc")
        return
    end

    -- if user wants to change area different than in GMCP, don't let him
    if gmcp.room.info.map and gmcp.room.info.map.name ~= area_name then
        amap:print_log("Nie zmienie obszaru, bo obecny jest w GMCP!")
        return
    end

    local area_id = amap:get_area_id(area_name)

    if not area_id then
        amap:print_log("Nie ma takiego obszaru, sprawdz '/pokaz_obszary'")
    end

    setRoomArea(amap.curr.id, area_id)
    centerview(amap.curr.id)
    amap:print_log("Obszar ustawiony")
end

function amap:add_stubs(room)
    if room.exits and room.id then
        -- retrieve all exit codes and set exit stubs
        local p_exits = amap:parse_exits(room.exits)

        for k, v in pairs(p_exits) do
            setExitStub(room.id, v, true)
        end

        if amap.options["laczenie_stubow"] == 0 then
            return
        end

        -- try to connect stubs
        local stubs = getExitStubs(room.id)
        if stubs and type(stubs) ~= "number" then
            for k, v in pairs(stubs) do
                local new_x, new_y, new_z = amap:get_new_coords(room.x, room.y, room.z, amap.exitmap[v])
                local neighbor_id = amap:room_exist(new_x, new_y, new_z, room.area)

                if neighbor_id ~= 0 then
                    -- connect stubs only if neighbor exist
                    connectExitStub(room.id, neighbor_id, v)

                    if amap.options["laczenie_stubow"] > 1 then
                        local opposite_dir_code = amap.opposite_exitmap[v]
                        local n_stubs = getExitStubs(neighbor_id)

                        if n_stubs and type(n_stubs) ~= "number" and amap:stub_list_contains_code(n_stubs, opposite_dir_code) then
                            connectExitStub(neighbor_id, room.id, opposite_dir_code)
                        end
                    end
                end
            end
        end
    end
end

function amap:remove_stubs(room_id)
    if not room_id then
        amap:print_log("Nie dostalem zadnego id")
    end

    local stubs = getExitStubs(room_id)
    if stubs and type(stubs) ~= "number" then
        for k, v in pairs(stubs) do
            setExitStub(room_id, v, false)
        end
    end

    amap:print_log("Zrobione")
end

function amap:room_exist(x, y, z, area)
    if x and y and z and area then
        local area_id = amap:get_area_id(area)
        if not area_id then
            area_id = amap:add_area(area)
        end

        local rooms = getRoomsByPosition(area_id, x, -y, z)
        if table.size(rooms) > 0 then
            return rooms[0]
        else
            return 0
        end
    end
end

function amap:get_room_by_hash(x, y, z, area)
    if x and y and z and area then
        local area_id = amap:get_area_id(area)
        if not area_id then
            area_id = amap:add_area(area)
        end

        local room = getRoomIDbyHash(amap:generate_hash(x, y, z, area))
        return room ~= -1 and room or 0
    end
end

function amap:get_current_location_hash()
    local tmp_loc = amap:extract_gmcp()
    if not (tmp_loc.x or tmp_loc.y or tmp_loc.z) then
        return false
    end
    local hash = amap:generate_hash(tmp_loc.x, tmp_loc.y, tmp_loc.z, tmp_loc.area)
    return hash
end

function amap:set_room_hash()
    if not amap.curr.id then
        amap:print_log("Ustaw lokacje, zeby ustawiac hash lokacji")
    end
    local tmp_loc = amap:extract_gmcp()
    local hash = amap:generate_hash(tmp_loc.x, tmp_loc.y, tmp_loc.z, tmp_loc.area)
    local room = getRoomIDbyHash(hash)
    if room ~= -1 and amap.curr.id ~= room then
        amap:print_log(string.format(
            "Lokacja na ktorej stoisz jest juz na mapie (x:%s, y:%s, z: %s, area: %s) - lokacja ID: %s", tmp_loc.x,
            tmp_loc
            .y, tmp_loc.z, tmp_loc.area, room))
    elseif amap.curr.id == room then
        amap:print_log("Dla tej lokacji jest ustawiony juz prawidlowy hash.")
    else
        setRoomIDbyHash(amap.curr.id, hash)
        amap:print_log(string.format("Hash dla lokacji ID: %s zostal ustawiony na: %s", amap.curr.id, hash))
    end
end

function amap:link_rooms(room_src, room_dst, dst)
    if room_src and room_dst and dst then
        if not setExit(room_src, room_dst, amap.long_to_short[dst]) then
            amap:print_log("Cos poszlo nie tak...")
            return
        end

        amap:print_log("Lokacje zlinkowane")
    end
end

function amap:color_room(color)
    if amap.color_table[color] then
        setRoomEnv(amap.curr.id, amap.color_table[color])

        amap:print_log("Kolor ustawiony")
    else
        amap:print_log("Ten kolor nie istnieje")
    end
end

function amap:print_room_info(room_id)
    local room_to_print = nil
    local internal_room_to_print = nil

    if room_id and string.starts(tostring(room_id), "i") then
        room_to_print = amap.internal_to_mudlet_id[room_id]
        internal_room_to_print = room_id
    elseif room_id then
        room_to_print = tonumber(room_id)
        internal_room_to_print = getRoomUserData(room_id, "internal_id")
    elseif amap.curr.id then
        room_to_print = amap.curr.id
        internal_room_to_print = getRoomUserData(amap.curr.id, "internal_id")
    else
        error("Wrong input")
    end

    if not getRoomArea(room_to_print) then
        amap:print_log("Nie ma lokacji o tym id")
        return
    end

    amap:print_log("Mudlet ID lokacji: <green>" .. room_to_print)
    amap:print_log("Internal ID lokacji: <green>" .. internal_room_to_print)
    amap:print_log("Rejon lokacji: <green>" .. getAreaTableSwap()[getRoomArea(room_to_print)])
    local x, y, z = getRoomCoordinates(room_to_print)
    y = -y
    amap:print_log("Koordynaty lokacji: <green>" .. x .. ", " .. y .. ", " .. z)
    amap:print_log("Waga lokacji: <green>" .. tostring(getRoomWeight(room_to_print)))
    amap:print_log("Wyjscia z lokacji: ")
    display(getRoomExits(room_to_print))

    amap:print_log("Wyjscia specjalne z lokacji: ")
    display(getSpecialExitsSwap(room_to_print))

    local user_data = getRoomUserData(room_to_print, "dir_bind")
    if user_data ~= "" then
        amap:print_log("Bindy kierunkowe: ")
        display(scripts.utils:deserialize_dir_bind(user_data))
    end

    amap:print_log("Nazwa lokacji: <green>" .. getRoomName(room_to_print))
    if getRoomUserData(room_to_print, "description") ~= "" then
        amap:print_log("Opis lokacji:")
        for i, j in pairs(string.split(getRoomUserData(room_to_print, "description"), "\\n")) do
            echo(j .. "\n")
        end
    end

    if getRoomUserData(room_to_print, "bind") ~= "" then
        amap:print_log("Bind lokacji: <green>" .. getRoomUserData(room_to_print, "bind"))
    end

    if getRoomUserData(room_to_print, "walk_pre_cmd") ~= "" then
        amap:print_log("Komendy bindowane przed ruchem: <green>" .. getRoomUserData(room_to_print, "walk_pre_cmd"))
    end

    if getRoomUserData(room_to_print, "walk_post_cmd") ~= "" then
        amap:print_log("Komendy bindowane po ruchu: <green>" .. getRoomUserData(room_to_print, "walk_post_cmd"))
    end

    if getRoomUserData(room_to_print, "note") ~= "" then
        amap:print_log("Notka lokacji:")
        for i, j in pairs(string.split(getRoomUserData(room_to_print, "note"), "\\n")) do
            echo(j .. "\n")
        end
    end

    if getRoomUserData(room_to_print, "team_follow_link") ~= "" then
        amap:print_log("Druzynowe skojarzenia: <green>" .. getRoomUserData(room_to_print, "team_follow_link"))
    end
end

function amap:set_drinkable_room(room_id)
    if not room_id then
        return nil
    end

    if getRoomUserData(room_id, "drinkable") == "true" then
        setRoomUserData(room_id, "drinkable", "")
        amap:print_log("Ok")
    elseif not setRoomUserData(room_id, "drinkable", "true") then
        amap:print_log("Cos poszlo nie tak...")
    else
        amap:print_log("Ok")
    end
end

function amap:set_gate_room(room_id, command)
    if not room_id then
        return nil
    end

    local gate_str = command ~= "" and command or "uderz w brame"

    if getRoomUserData(room_id, "gate") ~= "" then
        clearRoomUserDataItem(room_id, "gate")
        amap:print_log("Ok, usunieto ozaczenie jako brama")
    elseif not setRoomUserData(room_id, "gate", gate_str) then
        amap:print_log("Cos poszlo nie tak...")
    else
        amap:print_log("Ok, dodano komendy dla bramy: " .. gate_str)
    end

    setRoomEnv(room_id, 400)
end

function amap:set_room_weight(weight, room_id)
    local room_to_change = nil
    if room_id then
        room_to_change = room_id
    elseif not room_id and amap.curr.id then
        room_to_change = amap.curr.id
    else
        error("Wrong input")
    end

    if not weight then
        error("Wrong input")
    end

    setRoomWeight(room_to_change, weight)
    amap:print_log("Ok")
end

function amap:set_dir_bind(dir, bind)
    local d_dict = {}
    if getRoomUserData(amap.curr.id, "dir_bind") ~= "" then
        d_dict = scripts.utils:deserialize_dir_bind(getRoomUserData(amap.curr.id, "dir_bind"))
    end

    d_dict[amap.short_to_long[dir]] = bind
    setRoomUserData(amap.curr.id, "dir_bind", scripts.utils:serialize_dir_bind(d_dict))

    amap:print_log("Ok")
end

function amap:reset_dir_bind()
    setRoomUserData(amap.curr.id, "dir_bind", "")
    amap:print_log("Ok")
end

function alias_func_mapper_room_add_special_exit_room()
    amap:add_room_special_exit(matches[2], matches[3])
end

function alias_func_mapper_room_add_special_exit()
    amap:add_special_exit(matches[2], matches[3])
end

function alias_func_mapper_room_add_exit()
    amap:add_exit(tonumber(matches[2]), matches[3])
end

function alias_func_mapper_room_add_exit_from()
    amap:add_exit_from(tonumber(matches[2]), tonumber(matches[3]), matches[4])
end

function alias_func_mapper_room_color_room()
    amap:color_room(matches[2])
end

function alias_func_mapper_room_change_room_area()
    amap.change_room_area(matches[2])
end

function alias_func_mapper_room_add_room_located_on()
    amap:add_location_located_on(matches[2], matches[3])
end

function alias_func_mapper_room_add_room_located_on2()
    amap:add_location_located_on(matches[2], nil)
end

function alias_func_mapper_room_delete_stubs()
    if matches[3] then
        amap:remove_stubs(tonumber(matches[3]))
    else
        amap:remove_stubs(amap.curr.id)
    end
end

function alias_func_mapper_room_set_drinkable_room()
    amap:set_drinkable_room(amap.curr.id)
end

function alias_func_mapper_room_set_gate_room()
    amap:set_gate_room(amap.curr.id, matches[2])
end

function alias_func_mapper_room_set_weight()
    amap:set_room_weight(tonumber(matches[2]), nil)
end

function alias_func_mapper_room_set_weight_id()
    amap:set_room_weight(tonumber(matches[2]), tonumber(matches[3]))
end

function alias_func_mapper_room_set_dir_bind()
    amap:set_dir_bind(matches[2], matches[3])
end

function alias_func_mapper_room_reset_dir_bind()
    amap:reset_dir_bind(matches[2], matches[3])
end
