amap.blockers = amap.blockers or {
    is_blockable = false
}

function amap.blockers:init()
    scripts.event_register:register_singleton_event_handler("blocker1", "amapWalking", function() self:set_blockable(true) end)
    scripts.event_register:register_singleton_event_handler("blocker2", "gmcp.room.info", function() self:set_blockable(false) end)
end

function amap.blockers:block()
    if amap.mode == "off" then
        return
    end

    self:set_blockable(false)
    raiseEvent("amapBlockerFired")
    amap:move_backward()
    amap:terminate_walker()
end

function amap.blockers:set_blockable(state)
    self.is_blockable = state
end

function trigger_func_mapper_blockers_blocker_team_dependent()
    if amap.blockers.is_blockable then
        amap.blockers:block()
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

function trigger_func_blockers_unblockable()
    amap.blockers:set_blockable(false)
end

amap.blockers:init()
