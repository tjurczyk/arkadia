function gmcp_state_handler()
    if scripts.ui.cfg["footer_mode"] == "mode1" then
        scripts.ui:update_bars_mode("gauge")
    elseif scripts.ui.cfg["footer_mode"] == "mode2" or scripts.ui.cfg["footer_mode"] == "mode3" or
            scripts.ui.cfg["footer_mode"] == "mode4" or scripts.ui.cfg["footer_mode"] == "mode5" then
        scripts.ui:update_bars_mode("label")
    end
end

if scripts.event_handlers["skrypty/ui/gmcp_handlers/gmcp_state_handler.gmcp.char.state.gmcp_state_handler"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/ui/gmcp_handlers/gmcp_state_handler.gmcp.char.state.gmcp_state_handler"])
end

scripts.event_handlers["skrypty/ui/gmcp_handlers/gmcp_state_handler.gmcp.char.state.gmcp_state_handler"] = registerAnonymousEventHandler("gmcp.char.state", gmcp_state_handler)

