function exit_event_load_room()
    if io.exists(getMudletHomeDir() .. "/amap_last_curr_id.lua") then
        table.load(getMudletHomeDir() .. "/amap_last_curr_id.lua", amap.curr)
        centerview(amap.curr.id)
    end
end

if scripts.event_handlers["mapper/events/exit_event_load_room.sysLoadEvent.exit_event_load_room"] then
    killAnonymousEventHandler(scripts.event_handlers["mapper/events/exit_event_load_room.sysLoadEvent.exit_event_load_room"])
end

scripts.event_handlers["mapper/events/exit_event_load_room.sysLoadEvent.exit_event_load_room"] = registerAnonymousEventHandler("sysLoadEvent", exit_event_load_room)

