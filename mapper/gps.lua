amap.gps = amap.gps or {
    trigger_ids = {},
    room_id_to_gps_lines = {},
    room_id_to_line_delta = {},
    current_room_id_gps_index = {},
    current_room_id_line_trigger_id = {},
    room_id_to_within_room_ids = {},
    user_data_gps_key = "gps",
    gps_str_separator = "#"
}

local function trim5(s)
    return s:match '^%s*(.*%S)' or ''
end

function amap.gps:print_room_gps(room_id)
    if not room_id then
        error("wrong input in map_sync.gps:print_room_gps")
        return
    end

    local room_data_gps = getRoomUserData(room_id, amap.gps.user_data_gps_key)
    if not room_data_gps or room_data_gps == "" then
        cecho("\n <orange> Map Sync: nie ma zadnego gpsa dla tej lokacji\n")
        return
    end

    local gps_room_elements = yajl.to_value(room_data_gps)

    cecho("\n <orange> Map Sync: gps dla lokacji " .. tostring(room_id) .. "\n\n")
    for k, gps_room_element in pairs(gps_room_elements) do
        local room_gps_id = self:generate_room_gps_id(room_id, k)

        cecho(" <yellow>id<grey>:       " .. room_gps_id .. "\n")

        if gps_room_element.area_name and gps_room_element.area_name ~= "" then
            cecho(" <yellow>obszar<grey>:   " .. gps_room_element.area_name .. "\n")
        end

        if gps_room_element.within_room_ids and table.size(gps_room_element.within_room_ids) > 0 then
            cecho(" <yellow>lokacje<grey>:  " .. table.concat(gps_room_element.within_room_ids, ", ") .. "\n")
        end

        for k, gps_string_line in pairs(gps_room_element.gps_string_lines) do
            if k == 1 then
                cecho(" <yellow>trigger<grey>: \"" .. gps_string_line .. "\"\n")
            else
                cecho("          \"" .. gps_string_line .. "\"\n")
            end
        end

        cecho("\n")
    end
end

function amap.gps:add_gps_to_room(room_id, gps_str, line_delta, area_name, within_room_ids)
    if not room_id or not gps_str then
        error("wrong input in map_sync.gps:add_gps_to_room")
        return
    end

    local gps_string_lines = string.split(gps_str, amap.gps.gps_str_separator)
    if table.size(gps_string_lines) == 0 then
        error("gps_string_lines has 0 elements")
        return
    end

    local gps_dictionary = {}
    gps_dictionary.room_id = room_id
    gps_dictionary.gps_string_lines = gps_string_lines
    gps_dictionary.line_delta = line_delta
    gps_dictionary.area_name = area_name
    gps_dictionary.within_room_ids = within_room_ids

    local room_data_gps = getRoomUserData(room_id, amap.gps.user_data_gps_key)
    local gps_room_elements = {}
    if room_data_gps and room_data_gps ~= "" then
        gps_room_elements = yajl.to_value(room_data_gps)
    end

    table.insert(gps_room_elements, gps_dictionary)
    local yajl_gps_room_elements = yajl.to_string(gps_room_elements)
    setRoomUserData(room_id, amap.gps.user_data_gps_key, yajl_gps_room_elements)

    local final_msg = "\n <orange> Map Sync: dodalem gps do lokacji " .. tostring(room_id)

    if area_name then
        final_msg = final_msg .. " w obszarze " .. area_name
    end

    final_msg = final_msg .. ". Pamietaj aby zapisac mape przed wrzuceniem na serwer\n"
    cecho(final_msg)
end

function amap.gps:remove_gps(room_gps_id)
    local room_gps_id_array = string.split(room_gps_id, "_")
    if room_gps_id_array == nil or table.size(room_gps_id_array) ~= 2 then
        error("map_sync.gps:remove_gps got wrong argument")
        return
    end

    local room_id = room_gps_id_array[1]
    local room_gps_idx = tonumber(room_gps_id_array[2])

    local room_data_gps = getRoomUserData(room_id, self.user_data_gps_key)
    if not room_data_gps or room_data_gps == "" then
        cecho("\n<orange> Map Sync: nie znalazlem gps o id: " .. room_gps_id .. "\n")
        return
    end

    local gps_room_elements = yajl.to_value(room_data_gps)
    if room_data_gps and room_data_gps ~= "" then
        gps_room_elements = yajl.to_value(room_data_gps)
    end

    local filtered_gps_room_elements = {}
    for k, gps_room_element in pairs(gps_room_elements) do
        if k ~= room_gps_idx then
            table.insert(filtered_gps_room_elements, gps_room_element)
        end
    end

    if table.size(filtered_gps_room_elements) == table.size(gps_room_elements) then
        cecho("\n<orange> Map Sync: nie znalazlem gps o id: " .. room_gps_id .. "\n")
        return
    end

    local yajl_filtered_gps_room_elements = yajl.to_string(filtered_gps_room_elements)
    setRoomUserData(room_id, amap.gps.user_data_gps_key, yajl_filtered_gps_room_elements)
    cecho("\n<orange> Map Sync: ok, gps usuniety. Pamietaj o zapisie mapy przed wrzuceniem na serwer.\n")
end

function amap.gps:init_triggers()
    local gps_count = 0

    for id, name in pairs(getRooms()) do
        local room_data_gps = getRoomUserData(id, amap.gps.user_data_gps_key)
        if room_data_gps and room_data_gps ~= "" then
            local gps_data = yajl.to_value(room_data_gps)
            for k, v in pairs(gps_data) do
                amap.gps:init_trigger(id, k, v.gps_string_lines, v.line_delta, v.area_name, v.within_room_ids)
                gps_count = gps_count + 1
            end
        end
    end
    self.ready = true

    scripts:print_log("Zbudowalem " .. tostring(gps_count) .. " elementow gps\n", true)
end

function amap.gps:init_trigger(room_id, room_incremental_gps_number, gps_string_lines, line_delta, area_name, within_room_ids)
    if not room_id or not room_incremental_gps_number or not gps_string_lines then
        error("map_sync.gps:init_trigger got empty parameters")
        return
    end

    local room_gps_id = self:generate_room_gps_id(room_id, room_incremental_gps_number)

    local calculated_line_delta = table.size(gps_string_lines) - 1
    if line_delta then
        calculated_line_delta = tonumber(line_delta) - 1
    end

    local passable_area_name = ""
    if area_name and area_name ~= "" then
        passable_area_name = area_name
    end

    if within_room_ids and table.size(within_room_ids) > 0 then
        self.room_id_to_within_room_ids[room_gps_id] = {}
        for _, room_id in pairs(within_room_ids) do
            self.room_id_to_within_room_ids[room_gps_id][tonumber(room_id)] = true
        end
    end

    self.room_id_to_gps_lines[room_gps_id] = gps_string_lines
    self.room_id_to_line_delta[room_gps_id] = calculated_line_delta

    local trigger_exact_line = gps_string_lines[1]
    local trigger_id = tempExactMatchTrigger(trigger_exact_line, [[ map_sync_gps_first_line_match("]] .. room_id .. [[", "]] .. room_gps_id .. [[", ]] .. calculated_line_delta .. [[, "]] .. passable_area_name .. [[")]])
    self.trigger_ids[room_gps_id] = trigger_id
end

function map_sync_gps_first_line_match(room_id, room_gps_id, line_delta, area_name)
    if area_name and area_name ~= "" and area_name ~= amap.curr.area then
        -- not in the area of the gps, ending
        return
    elseif amap.gps.room_id_to_within_room_ids[room_gps_id] ~= nil and amap.gps.room_id_to_within_room_ids[room_gps_id][tonumber(amap.curr.id)] == nil then
        -- not in the within room ids, ending
        return
    elseif table.size(amap.gps.room_id_to_gps_lines[room_gps_id]) == 1 then
        -- the gps consists of a single line
        amap:set_position(room_id, true)
        cecho("\n<orange> Map Sync: gps " .. room_gps_id)
    else
        amap.gps.current_room_id_gps_index[room_gps_id] = 2
        local temp_line_trigger_id = tempLineTrigger(1, line_delta, [[ map_sync_gps_subsequent_line_check_match("]] .. room_id .. [[", "]] .. room_gps_id .. [[")]])
        amap.gps.current_room_id_line_trigger_id[room_gps_id] = temp_line_trigger_id
    end
end

function map_sync_gps_subsequent_line_check_match(room_id, room_gps_id)
    local current_line_id = amap.gps.current_room_id_gps_index[room_gps_id]
    local gps_lines_count = table.size(amap.gps.room_id_to_gps_lines[room_gps_id])
    local line_matched_trigger = trim5(line) == amap.gps.room_id_to_gps_lines[room_gps_id][current_line_id]
    if line_matched_trigger and current_line_id == gps_lines_count then
        -- matched and it is the last line, set gps
        amap:set_position(room_id, true)
        cecho("\n<orange> Map Sync: gps " .. room_gps_id)
    elseif line_matched_trigger then
        -- matched and line in the middle of multi-line, continuing
        amap.gps.current_room_id_gps_index[room_gps_id] = amap.gps.current_room_id_gps_index[room_gps_id] + 1
    else
        -- didn't match, just kill the line trigger
        killTrigger(amap.gps.current_room_id_line_trigger_id[room_gps_id])
    end
end

function amap.gps:generate_room_gps_id(room_id, room_incremental_gps_number)
    if not room_id or not room_incremental_gps_number then
        error("wrong input in map_sync.gps:generate_room_gps_id()")
        return
    end

    local room_gps_id = tostring(room_id) .. "_" .. tostring(room_incremental_gps_number)
    return room_gps_id
end


function alias_func_map_sync_add_gps()
    if amap.curr.id then
        amap.gps:add_gps_to_room(amap.curr.id, matches[2], nil, nil, nil)
    end
end

function alias_func_map_sync_add_gps_area()
    if amap.curr.id then
        amap.gps:add_gps_to_room(amap.curr.id, matches[2], nil, amap.curr.area, nil)
    end
end

function alias_func_map_sync_add_gps_within_rooms()
    local within_room_ids = string.split(matches[2], ",")

    if amap.curr.id then
        amap.gps:add_gps_to_room(amap.curr.id, matches[3], nil, nil, within_room_ids)
    end
end

function alias_func_map_sync_remove_gps()
    amap.gps:remove_gps(matches[2])
end


function alias_func_map_sync_show_gps()
    if amap.curr.id then
        amap.gps:print_room_gps(amap.curr.id)
    end
end

function alias_func_map_sync_show_gps_room()
    amap.gps:print_room_gps(tonumber(matches[2]))
end


scripts.event_register:register_event_handler("mapOpenEvent", function() amap.gps:init_triggers() end, true)