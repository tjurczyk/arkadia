scripts.event_register = scripts.event_register or {
    handlers = {}
}

--[[
    Register event handler and store its id

    Args:
    Just as in https://wiki.mudlet.org/w/Manual:Miscellaneous_Functions#registerAnonymousEventHandler
--]]
function scripts.event_register:register_event_handler(event, callback, onetime)
    local id = registerAnonymousEventHandler(event, callback, onetime)
    table.insert(scripts.event_register.handlers, id)
    return id
end

--[[
    Register event handler and store its id only if reference passed is nil
    Otherwise return that reference

    Args:
    reference: value to be checked as condition to register handler
    Just as in https://wiki.mudlet.org/w/Manual:Miscellaneous_Functions#registerAnonymousEventHandler
--]]
function scripts.event_register:register_singlton_event_handler(reference, event, callback, onetime)
   if reference ~= nil then
       return reference
   else
        return scripts.event_register:scripts.event_register:register_event_handler(event, callback, onetime)
   end
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

--[[
    Clear event register and kill all handlers
--]]
function scripts.event_register:kill_all_event_handlers()
    for k, v in pairs(scripts.event_register.handlers) do
        killAnonymousEventHandler(v)
    end
    scripts.scripts.event_register.handlers = {}
end