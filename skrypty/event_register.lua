scripts.event_register = scripts.event_register or {
    handlers = {}
}

function scripts.event_register:register_event_handler(id, event, callback, onetime)
    local onetime = onetime or false
    scripts.event_register:kill_event_handler(id)
    scripts.event_register.handlers[id] = registerAnonymousEventHandler(event, callback, onetime)
end

function scripts.event_register:kill_event_handler(id)
    if scripts.event_register.handlers[id] then
        killAnonymousEventHandler(scripts.event_register.handlers[id])
        scripts.event_register[id] = nil
    end
end