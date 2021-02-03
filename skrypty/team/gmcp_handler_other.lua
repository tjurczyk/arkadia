function gmcp_handler_other()
    if gmcp.objects and gmcp.objects.nums then
        ateam:collect_people_on_location()
    end
    ateam:print_status()
end

if scripts.event_handlers["skrypty/team/gmcp_handler_other.gmcp.room.info.gmcp_handler_other"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/team/gmcp_handler_other.gmcp.room.info.gmcp_handler_other"])
end

scripts.event_handlers["skrypty/team/gmcp_handler_other.gmcp.room.info.gmcp_handler_other"] = registerAnonymousEventHandler("gmcp.room.info", gmcp_handler_other)

if scripts.event_handlers["skrypty/team/gmcp_handler_other.gmcp.objects.nums.gmcp_handler_other"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/team/gmcp_handler_other.gmcp.objects.nums.gmcp_handler_other"])
end

scripts.event_handlers["skrypty/team/gmcp_handler_other.gmcp.objects.nums.gmcp_handler_other"] = registerAnonymousEventHandler("gmcp.objects.nums", gmcp_handler_other)

