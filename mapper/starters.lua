function trigger_func_mapper_starters_try_to_locate_start()
    if amap.logged_name == amap.locating["name"] and amap.locating["loc_id"] then
        amap:set_position(amap.locating["loc_id"], true)
    end
end

function trigger_func_mapper_starters_capture_login()
    amap.logged_name = multimatches[1][2]
    registerAnonymousEventHandler("gmcp.char", function()
        raiseEvent("loginSuccessful")
    end, true)
end

