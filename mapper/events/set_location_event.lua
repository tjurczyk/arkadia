function set_location_event(...)
    -- arg[3] is a marked room number
    amap:set_position(arg[3])
end

if scripts.event_handlers["mapper/events/set_location_event.setThisLocation.set_location_event"] then
    killAnonymousEventHandler(scripts.event_handlers["mapper/events/set_location_event.setThisLocation.set_location_event"])
end

scripts.event_handlers["mapper/events/set_location_event.setThisLocation.set_location_event"] = registerAnonymousEventHandler("setThisLocation", set_location_event)

