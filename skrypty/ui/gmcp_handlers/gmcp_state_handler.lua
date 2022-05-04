function gmcp_state_handler()
    scripts.ui:update_footer_main()
end

if scripts.event_handlers["skrypty/ui/gmcp_handlers/gmcp_state_handler.gmcp.char.state.gmcp_state_handler"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/ui/gmcp_handlers/gmcp_state_handler.gmcp.char.state.gmcp_state_handler"])
end

scripts.event_handlers["skrypty/ui/gmcp_handlers/gmcp_state_handler.gmcp.char.state.gmcp_state_handler"] = registerAnonymousEventHandler("gmcp.char.state", gmcp_state_handler)
