function amap.ui:reset_dirs()
    amap.ui.compass.active_dirs = {}
    amap.ui.compass.special_exit1 = nil
    amap.ui.compass.special_exit2 = nil
    amap.ui.compass.special_exit3 = nil
    for k, v in pairs(amap.ui.compass.dirs) do
        if  amap.ui.compass["button_" .. v] then
            amap.ui.compass["button_" .. v]:echo("")
            amap.ui.compass["button_" .. v]:setStyleSheet(amap.ui["normal_button"])
        end
    end
end

function amap.ui:reset_special_dirs()
    amap.ui.compass.active_dirs = {}
    amap.ui.compass.special_exit1 = nil
    amap.ui.compass.special_exit2 = nil
    amap.ui.compass.special_exit3 = nil
    amap.ui.compass["button_special1"]:echo("")
    amap.ui.compass["button_special1"]:setStyleSheet(amap.ui["normal_button"])
    amap.ui.compass["button_special2"]:echo("")
    amap.ui.compass["button_special2"]:setStyleSheet(amap.ui["normal_button"])
    amap.ui.compass["button_special3"]:echo("")
    amap.ui.compass["button_special3"]:setStyleSheet(amap.ui["normal_button"])
end

function amap_ui_set_dirs_trigger(dirs, leave_as_is)
    if not amap.ui.active then
        -- window not shown, nothing to do
        return
    end

    if not leave_as_is then
        amap.ui:reset_dirs()
    else
        amap.ui:reset_special_dirs()
    end

    local dir_set = amap.ui.use_simplified_compass and amap.ui["dir_to_symbol"] or amap.ui["dir_to_fancy_symbol"]

    -- do from dirs here
    local regular_dirs = {}
    if dirs then
        for k, v in pairs(dirs) do
            -- for each direction, set active
            local short_dir = nil

            if k == "dol" then
                short_dir = "down"
            elseif k == "gore" or k == "gora" then
                short_dir = "up"
            elseif amap.long_to_short[k] then
                short_dir = amap.long_to_short[k]
            elseif amap.short_to_long[k] then
                short_dir = k
            end

            if short_dir then
                regular_dirs[short_dir] = true
                if v == false then
                    amap.ui.compass["button_" .. short_dir]:echo("<center>\"</center>")
                else
                    amap.ui.compass["button_" .. short_dir]:echo("<center>" .. dir_set[short_dir] .. "</center>")
                end
            end
        end
    end

    local exits = getSpecialExitsSwap(amap.curr.id)
    local swap = {}
    for k,v in pairs(exits) do
        swap[v] = swap[v] or k
    end
    local special_dirs = {}
    if not exits then
        raiseEvent("amapCompassDrawingDone", regular_dirs, special_dirs)
        return
    end

    local id = 1
    for k, v in pairs(swap) do
        if not v:starts("script") then
            special_dirs[v] = true
            amap.ui:set_special_dir(id, v)
            id = id + 1
            if id == 4 then
                break
            end
        end
    end

    raiseEvent("amapCompassDrawingDone", regular_dirs, special_dirs)
end

function amap.ui:set_special_dir(id, dir)
    amap.ui.compass["special_exit" .. id] = dir
    amap.ui.compass["button_special" .. id]:echo("<center>" .. dir .. "<center>")
end

function amap.ui:add_special_dir_if_possible(dir)
    for id = 1, 3 do
        if amap.ui.compass["special_exit" .. id] == nil then
            amap.ui:set_special_dir(id, dir)
            return
        end
    end
end

function amap.ui:mapper_mode(enabled)
    if amap.ui.compass and amap.ui.compass.button_dummy then
        if not enabled then
            amap.ui.compass.button_dummy:setStyleSheet(amap.ui.inactive_mapper)
        else
            amap.ui.compass.button_dummy:setStyleSheet(amap.ui.normal_button)
        end
    end
end

