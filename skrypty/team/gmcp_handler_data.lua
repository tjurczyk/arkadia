function gmcp_handler_data()
    ateam:parse_objects_data()
    ateam:print_status()
end

if scripts.event_handlers["skrypty/team/gmcp_handler_data.gmcp.objects.data.gmcp_handler_data"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/team/gmcp_handler_data.gmcp.objects.data.gmcp_handler_data"])
end

scripts.event_handlers["skrypty/team/gmcp_handler_data.gmcp.objects.data.gmcp_handler_data"] = registerAnonymousEventHandler("gmcp.objects.data", gmcp_handler_data)

