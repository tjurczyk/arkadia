function trigger_func_mapper_directions_ui_wyjscia()
    local dirs = amap:parse_trigger_exits(matches[6])

    if amap.shorten_exits then
        selectCurrentLine()
        deleteLine()
        local str = "\n-----:"

        for dir, _ in pairs(dirs) do
            str = str .. " " .. string.upper(dir)
        end
        str = str .. "\n"

        cecho("<orange>" .. str)
    end


    amap_ui_set_dirs_trigger(dirs)
end

function trigger_func_mapper_directions_ui_wyjscia_all()
    local dirs = { ["n"] = true, ["nw"] = true, ["w"] = true, ["sw"] = true, ["s"] = true, ["se"] = true, ["e"] = true, ["ne"] = true }

    if amap.shorten_exits then
        selectCurrentLine()
        deleteLine()
        local str = "\n-----:"

        for i, dir in pairs(dirs) do
            str = str .. " " .. string.upper(dir)
        end
        str = str .. "\n"

        cecho("<LawnGreen>" .. str)
    end

    amap_ui_set_dirs_trigger(dirs)
end

function trigger_func_mapper_directions_ui_wyjscia_2()
    local dirs = amap:parse_trigger_exits(matches[2])
    local dirs2 = amap:parse_trigger_exits(matches[3])

    for dir, _ in pairs(dirs2) do dirs[dir] = true end

    if amap.shorten_exits then
        selectCurrentLine()
        deleteLine()
        local str = "\n-----:"

        for dir, _ in pairs(dirs) do
            str = str .. " " .. string.upper(dir)
        end
        str = str .. "\n"

        cecho("<orange>" .. str)
    end

    amap_ui_set_dirs_trigger(dirs)
end

function trigger_func_mapper_directions_ui_wyjscia_2_1()
    local dirs = amap:parse_trigger_exits(matches[2])
    local dirs2 = amap:parse_trigger_exits(matches[3])
    local dirs3 = amap:parse_trigger_exits(matches[4])

    for dir, _ in pairs(dirs2) do dirs[dir] = true end
    for dir, _ in pairs(dirs3) do dirs[dir] = true end

    if amap.shorten_exits then
        selectCurrentLine()
        deleteLine()
        local str = "\n-----:"

        for dir, _ in pairs(dirs) do
            str = str .. " " .. string.upper(dir)
        end
        str = str .. "\n"

        cecho("<orange>" .. str)
    end

    amap_ui_set_dirs_trigger(dirs)
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

    amap_ui_set_dirs_trigger(dirs)
end

