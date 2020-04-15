function amap.ui:reset_dirs()
    amap.ui.compass.active_dirs = {}
    amap.ui.compass.special_exit1 = nil
    amap.ui.compass.special_exit2 = nil
    amap.ui.compass.special_exit3 = nil
    for k, v in pairs(amap.ui.compass.dirs) do
        amap.ui.compass["button_" .. v]:echo("")
        amap.ui.compass["button_" .. v]:setStyleSheet(amap.ui["normal_button"])
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

    -- do from dirs here
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

            if short_dir and v == false then
                amap.ui.compass["button_" .. short_dir]:echo("<center>\"</center>")
            elseif short_dir then
                amap.ui.compass["button_" .. short_dir]:echo("<center>" .. amap.ui["dir_to_symbol"][short_dir] .. "</center>")
            end
        end
    end

    local exits = getSpecialExitsSwap(amap.curr.id)
    if not exits then
        return
    end

    local id = 1
    for k, v in pairs(exits) do
        amap.ui.compass["special_exit" .. id] = k
        amap.ui.compass["button_special" .. id]:echo("<center>" .. k .. "<center>")
        id = id + 1
        if id == 4 then
            break
        end
    end
end

function amap.ui:mapper_mode(enabled)
    if not enabled then
        amap.ui.compass.button_dummy:setStyleSheet(amap.ui.inactive_mapper)
    else
        amap.ui.compass.button_dummy:setStyleSheet(amap.ui.normal_button)
    end
end

