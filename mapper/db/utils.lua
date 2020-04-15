function amap.db:get_room_id(passed_room_id)
    if not passed_room_id and (not amap.curr.id or amap.curr.id == -1) then
        amap:print_log("Nie dostalem/zdobylem prawidlowego id lokacji")
        return nil
    elseif not passed_room_id then
        return amap.curr.id
    else
        return passed_room_id
    end
end

function amap.db:get_printable_rooms(rooms)
    if not rooms then
        error("Wrong input")
    end

    local s = "\n <yellow>Numer    <grey>| <yellow>Odleglosc    | <yellow>Nazwa\n"
    s = s .. "<grey>----------+--------------+-------------------------------------------------------------------------\n"

    for k, v in pairs(rooms) do
        s = s .. "<green> " .. string.sub(tostring(v) .. "        ", 1, 8) .. "<grey> | "
        s = s .. "<orange>" .. string.sub(tostring(amap.db:calculate_path_cost(amap.curr.id, v)) .. "            ", 1, 12) .. "" .. "<grey> |"
        s = s .. " " .. string.sub(getRoomName(v) .. "                                                                                                   ", 1, 72)
        s = s .. "\n"
    end

    return s
end

function amap.db:calculate_path_cost(room_from, room_to)
    --
    --
    -- TODO: This is not using weights now!
    -- Must be added: iterate through path and calculate cost
    --

    local path = getPath(room_from, room_to)
    if not path then
        return 100000000
    else
        return table.size(speedWalkPath)
    end
end

function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function amap.db:separate_follow_links(room_id)
    local data = getRoomUserData(amap.curr.id, "team_follow_link")
    if data == "" then
        return {}
    end

    local items = string.split(data, "#")
    local ret_dict = {}

    for k, v in pairs(items) do
        -- get 'from' and 'to'
        local splitted = string.split(v, "*")
        ret_dict[splitted[1]] = splitted[2]
    end

    return ret_dict
end

