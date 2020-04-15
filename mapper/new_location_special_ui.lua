function new_location_special_ui()
    amap_ui_set_dirs_trigger(nil)
end

if scripts.event_handlers["mapper/new_location_special_ui.amapNewLocation.new_location_special_ui"] then
    killAnonymousEventHandler(scripts.event_handlers["mapper/new_location_special_ui.amapNewLocation.new_location_special_ui"])
end

scripts.event_handlers["mapper/new_location_special_ui.amapNewLocation.new_location_special_ui"] = registerAnonymousEventHandler("amapNewLocation", new_location_special_ui)

