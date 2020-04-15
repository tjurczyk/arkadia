function ui_mapper_loaded_event()
    tempTimer(0.4, function() expandAlias("/ui_restart", false) end)
    scripts.ui.map_loaded = true

    if amap and amap.curr and amap.curr.id then
        centerview(amap.curr.id)
    end
end

if scripts.event_handlers["skrypty/ui/ui_mapper_loaded_event.mapOpenEvent.ui_mapper_loaded_event"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/ui/ui_mapper_loaded_event.mapOpenEvent.ui_mapper_loaded_event"])
end

scripts.event_handlers["skrypty/ui/ui_mapper_loaded_event.mapOpenEvent.ui_mapper_loaded_event"] = registerAnonymousEventHandler("mapOpenEvent", ui_mapper_loaded_event)

