function shortcuts_save_profile()
    amap.shortcuts:save_shortcuts()
end

if scripts.event_handlers["mapper/events/shortcuts_save_profile.sysExitEvent.shortcuts_save_profile"] then
    killAnonymousEventHandler(scripts.event_handlers["mapper/events/shortcuts_save_profile.sysExitEvent.shortcuts_save_profile"])
end

scripts.event_handlers["mapper/events/shortcuts_save_profile.sysExitEvent.shortcuts_save_profile"] = registerAnonymousEventHandler("sysExitEvent", shortcuts_save_profile)

