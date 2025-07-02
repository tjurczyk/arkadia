scripts.event_register = scripts.event_register or {
    handlers = {}
}


--- Register event handler and store its id
---
--- Args:
--- * `event`: event's name
--- * `callback`: callable function
--- * `onetime`: if one time
---
--- Just as in https://wiki.mudlet.org/w/Manual:Miscellaneous_Functions#registerAnonymousEventHandler
function scripts.event_register:register_event_handler(event, callback, onetime)
    local mudlet_id = registerAnonymousEventHandler(event, callback, onetime)
    local internal_id = #scripts.event_register.handlers + 1
    scripts.event_register.handlers[internal_id] = mudlet_id
    return internal_id
end

--- Register event handler and store its id only if reference passed is nil
--- Otherwise return that reference
---
--- Args:
--- * `internal_id`: internal handler's id to be registered as singleton.
---
--- Just as in https://wiki.mudlet.org/w/Manual:Miscellaneous_Functions#registerAnonymousEventHandler
function scripts.event_register:register_singleton_event_handler(internal_id, event, callback, onetime)
    if scripts.event_register.handlers[internal_id] ~= nil then
        return internal_id
    else
        return scripts.event_register:register_event_handler(event, callback, onetime)
   end
end

--- Force kill handler with internal_id, then register a new handler and return a new handler id.
---
--- Args:
--- * `internal_id`: internal handler's id to be killed.
---
--- Just as in https://wiki.mudlet.org/w/Manual:Miscellaneous_Functions#registerAnonymousEventHandler
function scripts.event_register:force_register_event_handler(internal_id, event, callback, onetime)
    if scripts.event_register.handlers[internal_id] ~= nil then
        pcall(killAnonymousEventHandler, scripts.event_register.handlers[internal_id])
    end
    return scripts.event_register:register_event_handler(event, callback, onetime)
end


--- Simply remove and kill event handler from register
---
--- Args:
--- * `id` - id under which event was registered
function scripts.event_register:kill_event_handler(internal_id)
    if scripts.event_register.handlers[internal_id] then
        killAnonymousEventHandler(scripts.event_register.handlers[internal_id])
        scripts.event_register.handlers[internal_id] = nil
    end
end

--- Clear event register and kill all handlers
function scripts.event_register:kill_all_event_handlers()
    for _, mudlet_id in pairs(scripts.event_register.handlers) do
        killAnonymousEventHandler(mudlet_id)
    end
    scripts.event_register.handlers = {}
end
