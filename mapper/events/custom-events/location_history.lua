function amap_add_location_history()
    List.push(amap.history, amap.curr.id)
end

function amap_step_back_perform()
    local location_id = List.popright(amap.history)
    local plocation_id = List.peek_last(amap.history)

    if not plocation_id then
        -- put it back, nothing more
        List.push(amap.history, location_id)
        return
    end

    amap.curr.id = plocation_id
    local curr_area = getRoomArea(amap.curr.id)
    amap.curr.area = getRoomAreaName(curr_area)

    amap.curr.x, amap.curr.y, amap.curr.z = getRoomCoordinates(amap.curr.id)
    amap.curr.y = -amap.curr.y

    centerview(amap.curr.id)
    amap:copy_loc(amap.prev, amap.curr)
    amap_ui_set_dirs_trigger(getRoomExits(amap.curr.id))
end

registerAnonymousEventHandler("amapNewLocation", "amap_add_location_history")

