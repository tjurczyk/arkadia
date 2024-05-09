function amap_check_pre_post_room_event(...)
    if not arg then
        return nil
    end

    local pre_cmd = getRoomUserData(arg[2], "walk_pre_cmd")
    local post_cmd = getRoomUserData(arg[2], "walk_post_cmd")

    if pre_cmd ~= "" and pre_cmd ~= "<reset>" then
        amap:add_walk_pre_cmd(pre_cmd)
    elseif post_cmd ~= "" and post_cmd ~= "<reset>" then
        amap:add_walk_post_cmd(post_cmd)
    end

    if pre_cmd == "<reset>" or post_cmd == "<reset>" then
        amap:reset_walk_cmd()
    end
end

registerAnonymousEventHandler("amapNewLocation", "amap_check_pre_post_room_event")
