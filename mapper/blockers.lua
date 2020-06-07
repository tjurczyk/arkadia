amap.blockers = amap.blockers or {
    is_blockable = false
}

function amap.blockers:init()
    scripts.event_register:register_event_handler("amapWalking", function() self:set_blockable(true) end)
    scripts.event_register:register_event_handler("gmcp.room.info", function() self:set_blockable(false) end)
end

function amap.blockers:block()
    if amap.mode == "off" then
        return
    end

    raiseEvent("amapBlockerFired")
    amap:move_backward()
    amap:terminate_walker()
end

function amap.blockers:set_blockable(state)
    self.is_blockable = state
end

function trigger_func_mapper_blockers_blockers()
    amap.blockers:block()
end

function trigger_func_mapper_blockers_blocker_team_dependent()
    -- they only work if no team or team and I'm the leader

    if amap.mode == "off" then
        return
    end

    if ateam.objs[ateam.my_id]["team_leader"] or not ateam.objs[ateam.my_id]["team"] or self.is_blockable then
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

function trigger_func_mapper_blockers_gargoyles()
    --if table.contains({17153, 171642}, amap.curr.id) then
    --    return
    --end
    --
    --amap.blockers:block()
    if amap.blockers.is_blockable then
        amap.blockers:block()
    end
end

amap.blockers:init()
