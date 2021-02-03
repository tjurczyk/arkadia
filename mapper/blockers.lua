amap.blockers = amap.blockers or {
    is_experimental = false,
    is_blockable = false,
    handler_walking = false,
    handler_gmcp = false
}

function amap.blockers:init()
    self.handler_walking = scripts.event_register:register_singleton_event_handler(self.handler_walking, "amapWalking", function() self:set_blockable(true) end)
    self.handler_gmcp = scripts.event_register:register_singleton_event_handler(self.handler_gmcp, "gmcp.room.info", function() self:set_blockable(false) end)
end

function amap.blockers:block()
    if amap.mode == "off" then
        return
    end

    if not self.is_blockable and self.is_experimental then
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

function trigger_func_mapper_blockers_blocker()
    amap.blockers:block()
end

function trigger_func_mapper_blockers_blocker_team_dependent()
    if (ateam.objs[ateam.my_id]["team_leader"] or not ateam.objs[ateam.my_id]["team"]) or amap.blockers.is_experimental then
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
