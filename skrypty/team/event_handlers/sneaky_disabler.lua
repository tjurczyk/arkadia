function sneaky_disabler()
    if ateam and ateam.objs and ateam.my_id then
        if ateam.objs[ateam.my_id]["attack_num"] and amap.walk_mode > 1 then
            scripts_ui_info_sneaky_click(1)
        end
    end
end


if scripts.event_handlers["skrypty/team/event_handlers/sneaky_disabler.gmcp.objects.data.sneaky_disabler"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/team/event_handlers/sneaky_disabler.gmcp.objects.data.sneaky_disabler"])
end

scripts.event_handlers["skrypty/team/event_handlers/sneaky_disabler.gmcp.objects.data.sneaky_disabler"] = registerAnonymousEventHandler("gmcp.objects.data", sneaky_disabler)

