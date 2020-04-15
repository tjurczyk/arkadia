function shortcuts_load_profile()
    tempTimer(3.3, function() amap.shortcuts:load_shortcuts() end)
end

if scripts.event_handlers["mapper/events/shortcuts_load_profile.sysLoadEvent.shortcuts_load_profile"] then
    killAnonymousEventHandler(scripts.event_handlers["mapper/events/shortcuts_load_profile.sysLoadEvent.shortcuts_load_profile"])
end

scripts.event_handlers["mapper/events/shortcuts_load_profile.sysLoadEvent.shortcuts_load_profile"] = registerAnonymousEventHandler("sysLoadEvent", shortcuts_load_profile)

