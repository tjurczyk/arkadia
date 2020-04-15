function trigger_func_mapper_blockers_blockers()
    if amap.mode == "off" then
        return
    end

    raiseEvent("amapBlockerFired")
    amap:move_backward()
    amap:terminate_walker()
end

function trigger_func_mapper_blockers_blockers2()
    if amap.mode == "off" then
        return
    end

    raiseEvent("amapBlockerFired")
    amap:move_backward()
    amap:terminate_walker()
end

function trigger_func_mapper_blockers_blockers3()
    if amap.mode == "off" then
        return
    end

    raiseEvent("amapBlockerFired")
    amap:move_backward()
    amap:terminate_walker()
end

function trigger_func_mapper_blockers_blocker_team_dependent()
    -- they only work if no team or team and I'm the leader

    if amap.mode == "off" then
        return
    end

    if ateam.objs[ateam.my_id]["team_leader"] or not ateam.objs[ateam.my_id]["team"] then
        raiseEvent("amapBlockerFired")
        amap:move_backward()
        amap:terminate_walker()
    end
end

function trigger_func_mapper_blockers_blockers_block()
    if string.match(matches[2], "wsciekla piane z ust") then
        return
    end

    if amap.mode == "off" then
        return
    end

    raiseEvent("amapBlockerFired")
    amap:move_backward()
    amap:terminate_walker()
end

