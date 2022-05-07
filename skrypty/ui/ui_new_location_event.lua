function ui_new_location_event(...)
    if not amap["went_sneaky"] then
        scripts.ui.info_hidden_value = ""
        scripts.ui.states_window_nav_states["hidden_state"] = ""
        disableTimer("hidden_timer")
        raiseEvent("hidden_state", "")
    else
        scripts.ui.info_hidden_value = 0
        scripts.ui.states_window_nav_states["hidden_state"] = 0
        enableTimer("hidden_timer")
        raiseEvent("hidden_state", 0)
    end

    amap["went_sneaky"] = false
end



if scripts.event_handlers["skrypty/ui/ui_new_location_event.amapNewLocation.ui_new_location_event"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/ui/ui_new_location_event.amapNewLocation.ui_new_location_event"])
end

scripts.event_handlers["skrypty/ui/ui_new_location_event.amapNewLocation.ui_new_location_event"] = registerAnonymousEventHandler("amapNewLocation", ui_new_location_event)

