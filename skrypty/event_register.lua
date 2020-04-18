scripts.event_register = scripts.event_register or {
    handlers = {}
}

--[[
    Register event handler only ONCE under certain ID
    Upon consecutive attempts to register kill previous one and register
--]]
function scripts.event_register:register_event_handler(id, event, callback, onetime)

    local onetime = onetime or false
    scripts.event_register:kill_event_handler(id)
    scripts.event_register.handlers[id] = registerAnonymousEventHandler(event, callback, onetime)
end

--[[
    Simply remove and kill event handler from register

    Args:
    id - id under which event was registered
--]]
function scripts.event_register:kill_event_handler(id)

    if scripts.event_register.handlers[id] then
        killAnonymousEventHandler(scripts.event_register.handlers[id])
        scripts.event_register[id] = nil
    end
end