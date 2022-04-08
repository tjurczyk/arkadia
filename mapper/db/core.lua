function amap.db:set_name(room_id, room_name)
    local room_to_set = amap.db:get_room_id(room_id)

    if not room_to_set or not room_name then
        error("Wrong input")
    end

    setRoomName(room_to_set, room_name)
    amap:print_log("Nazwa lokacji <green>" .. tostring(room_to_set) .. "<tomato> ustawiona na: <green>" .. room_name .. "<tomato>")
end

function amap.db:set_desc(room_id, room_desc)
    local room_to_set = amap.db:get_room_id(room_id)

    if not room_to_set or not room_desc then
        error("Wrong input")
    end

    setRoomUserData(room_to_set, "description", room_desc)
    amap:print_log("Opis lokacji <green>" .. tostring(room_to_set) .. "<tomato> ustawiony")
end

function amap.db:switch_show_notes()
    if amap.db.show_notes then
        amap.db.show_notes = false
        amap:print_log("Ok, nie bede pokazywal notek")
    else
        amap.db.show_notes = true
        amap:print_log("Ok, bede pokazywal notki")
    end
end

function amap.db:switch_show_binds()
    if amap.db.show_binds then
        amap.db.show_binds = false
        amap:print_log("Ok, nie bede pokazywal bindow")
    else
        amap.db.show_binds = true
        amap:print_log("Ok, bede pokazywal bindy")
    end
end

function amap.db:search_rooms(phrase, top_only)
    if not amap.curr.id then
        error("amap.curr.id not set")
    end

    if not phrase or phrase == "" then
        return
    end

    local found_rooms = {}
    local path_costs = {}
    local number_found = 0

    for k, v in pairs(getRooms()) do
        if string.find(string.lower(getRoomName(k)), string.lower(phrase)) then
            -- this is when phrase found in room name
            number_found = number_found + 1

            -- calculate path cost
            local path_cost = amap.db:calculate_path_cost(amap.curr.id, k)

            -- check if there is already some room with the same path cost
            -- if so, add it to the list
            -- if not, create a single list with it
            -- also, add the cost to the array
            if found_rooms[path_cost] then
                table.insert(found_rooms[path_cost], k)
            else
                found_rooms[path_cost] = { k }
                table.insert(path_costs, path_cost)
            end

        elseif string.find(string.lower(getRoomUserData(k, "description")), string.lower(phrase)) then
            -- this is when phrase found in room description
            number_found = number_found + 1

            local path_cost = amap.db:calculate_path_cost(amap.curr.id, k)

            if found_rooms[path_cost] then
                table.insert(found_rooms[path_cost], k)
            else
                found_rooms[path_cost] = { k }
                table.insert(path_costs, path_cost)
            end
        end
    end

    local s = ""

    if table.size(path_costs) == 0 then
        local s = "Nic nie znalazlem"

    else
        table.sort(path_costs)
        local sorted_found_rooms = {}
        local how_many = 0

        -- retrieve room_ids
        for k, v in pairs(path_costs) do

            -- for this cost, get room(s) with this cost
            for i, j in pairs(found_rooms[v]) do
                table.insert(sorted_found_rooms, j)
            end

            -- increment how_many by the number of rooms with this cost
            how_many = how_many + table.size(found_rooms[v])

            if how_many >= 5 and top_only then
                -- if top_only is true and we found ~5, stop
                break
            end

            if v == 100000000 then
                -- if 100000000 was just processed, all its rooms have been printed
                -- (they are stored under single key in found_rooms)
                break
            end
        end

        if top_only then
            s = "Znalazlem <green>" .. tostring(number_found) .. "<tomato> lokacji, najblizsze:\n"
        else
            s = "Znalazlem <green>" .. tostring(number_found) .. "<tomato> lokacji:\n"
        end

        s = s .. amap.db:get_printable_rooms(sorted_found_rooms)
    end

    amap:print_log(s)
end

function amap.db:add_follow_link(room_id, from_link, to_link)
    local room_to_set = amap.db:get_room_id(room_id)

    if not room_to_set or not from_link or not to_link then
        error("Wrong input")
    end

    local curr_data = getRoomUserData(room_to_set, "team_follow_link")
    if curr_data ~= "" then
        local new_data = curr_data .. "#" .. from_link .. "*" .. to_link
        setRoomUserData(room_to_set, "team_follow_link", new_data)
        amap:print_log("Ok, nowe skojarzenia dla lokacji<green> " .. tostring(room_to_set) .. "<tomato> to: <green>" .. tostring(new_data))
    else
        setRoomUserData(room_to_set, "team_follow_link", from_link .. "*" .. to_link)
        amap:print_log("Ok, ustawione skojarzenie dla lokacji<green> " .. tostring(room_to_set) .. "<tomato>: <green>" .. tostring(from_link .. "*" .. to_link))
    end
end

function amap.db:reset_follow_link(room_id)
    local room_to_set = amap.db:get_room_id(room_id)

    if not room_to_set then
        error("Wrong input")
    end

    setRoomUserData(room_to_set, "team_follow_link", "")
    amap:print_log("Ok, usuniete skojarzenia dla lokacji: " .. tostring(room_to_set))
end

