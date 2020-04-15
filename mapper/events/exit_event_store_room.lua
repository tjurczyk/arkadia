function exit_event_store_room()
    table.save(getMudletHomeDir() .. "/amap_last_curr_id.lua", amap.curr)
end

if scripts.event_handlers["mapper/events/exit_event_store_room.sysExitEvent.exit_event_store_room"] then
    killAnonymousEventHandler(scripts.event_handlers["mapper/events/exit_event_store_room.sysExitEvent.exit_event_store_room"])
end

scripts.event_handlers["mapper/events/exit_event_store_room.sysExitEvent.exit_event_store_room"] = registerAnonymousEventHandler("sysExitEvent", exit_event_store_room)

