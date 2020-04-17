scripts.event_register = scripts.event_register or {
    handlers = {}
}

function scripts.event_register:register_event_handler(id, event, callback, onetime)
    local onetime = onetime or false
    local final_callback = callback or function() end
    scripts.event_register:kill_event_handler(id)
    if onetime then
        final_callback = function()
            scripts.event_register[id] = nil
            callback()
        end
    end
    scripts.event_register.handlers[id] = registerAnonymousEventHandler(event, final_callback, onetime)
end

function scripts.event_register:kill_event_handler(id)
    if scripts.event_register.handlers[id] then
        killAnonymousEventHandler(id)
        scripts.event_register[id] = nil
    end
end