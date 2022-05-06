function ui_new_location_event(...)
    if not amap["went_sneaky"] then
        trigger_func_skrypty_ui_footer_elements_hidden_off()
    else
        trigger_func_skrypty_ui_footer_elements_hidden_on()
    end

    amap["went_sneaky"] = false
end



if scripts.event_handlers["skrypty/ui/ui_new_location_event.amapNewLocation.ui_new_location_event"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/ui/ui_new_location_event.amapNewLocation.ui_new_location_event"])
end

scripts.event_handlers["skrypty/ui/ui_new_location_event.amapNewLocation.ui_new_location_event"] = registerAnonymousEventHandler("amapNewLocation", ui_new_location_event)

