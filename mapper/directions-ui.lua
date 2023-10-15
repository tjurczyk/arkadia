amap.directions_ui = amap.directions_ui or {}

function amap.directions_ui:handle_exits(dirs, any_direction)
    if amap.shorten_exits then
        local str = "\n-----:"

        for dir, _ in pairs(dirs) do
            str = str .. " " .. string.upper(dir)
        end
        str = str .. "\n"
        local color = any_direction and "LawnGreen" or "orange"
        creplaceLine("<" .. color .. ">" .. str)
    end


    amap_ui_set_dirs_trigger(dirs)
end

function trigger_func_mapper_directions_ui_wyjscia()
    local dirs = amap:parse_trigger_exits(matches[2])
    amap.directions_ui:handle_exits(dirs)
end

function trigger_func_mapper_directions_ui_wyjscia_miasto(non_standard, standard)
    local dirs_standard = amap:parse_trigger_exits(standard)
    local dirs_all = amap:parse_trigger_exits2(non_standard, dirs_standard)
    amap.directions_ui:handle_exits(dirs_all)
end


function trigger_func_mapper_directions_ui_wyjscia_all()
    local dirs = { ["n"] = true, ["nw"] = true, ["w"] = true, ["sw"] = true, ["s"] = true, ["se"] = true, ["e"] = true, ["ne"] = true }
    amap.directions_ui:handle_exits(dirs)
end

function trigger_func_mapper_directions_ui_wyjscia_all_ud()
    local dirs = { ["n"] = true, ["nw"] = true, ["w"] = true, ["sw"] = true, ["s"] = true, ["se"] = true, ["e"] = true, ["ne"] = true, ["d"] = true, ["u"] = true }
    amap.directions_ui:handle_exits(dirs)
end

function trigger_func_mapper_directions_ui_wyjscia_2()
    local dirs = amap:parse_trigger_exits(matches[2])
    local dirs2 = amap:parse_trigger_exits(matches[3])

    for dir, _ in pairs(dirs2) do dirs[dir] = true end

    amap.directions_ui:handle_exits(dirs)
end

function trigger_func_mapper_directions_ui_wyjscia_2_1()
    local dirs = amap:parse_trigger_exits(matches[2])
    local dirs2 = amap:parse_trigger_exits(matches[3])
    local dirs3 = amap:parse_trigger_exits(matches[4])

    for dir, _ in pairs(dirs2) do dirs[dir] = true end
    for dir, _ in pairs(dirs3) do dirs[dir] = true end

    amap.directions_ui:handle_exits(dirs)
end

function trigger_func_mapper_directions_ui_neg_wyjscia_2()
    local dirs = amap:parse_trigger_exits(matches[2])

    -- if combined, collect and merge
    if matches[3] then
        local dirs2 = amap:parse_trigger_exits(matches[3])
        for dir, _ in pairs(dirs2) do dirs[dir] = true end
    end

    -- build table with false dirs (negations)
    for k, v in pairs(amap.short_to_long) do
        if dirs[k] then
            dirs[k] = false
        else
            if ((k == "u" or k == "up" or k == "d" or k == "down") and dirs[k]) or (k ~= "u" and k ~= "up" and k ~= "d" and k ~= "down") then
                dirs[k] = true
            end
        end
    end

    amap.directions_ui:handle_exits(dirs)
end

function trigger_func_mapper_directions_ui_oboz()
    local dirs = {["sw"] = true, ["se"] = true, ["n"] = true, ["wyjscie"] = true}
    amap.directions_ui:handle_exits(dirs)
    amap:locate_on_next_location()
end

function trigger_func_mapper_directions_add_special_camp()
    amap.ui:add_special_dir_if_possible("oboz")
end

function trigger_func_mapper_directions_elfi_okret()
    if gmcp.gmcp_msgs.type == "room.contents.object" then
        amap.ui:add_special_dir_if_possible("wejdz na bialy okret")
    end
end

function trigger_func_mapper_directions_szkuner()
    if gmcp.gmcp_msgs.type == "room.contents.object" then
        amap.ui:add_special_dir_if_possible("wejdz na szkuner")
    end
end

function trigger_func_mapper_locate_on_next()
    amap:locate_on_next_location()
end
