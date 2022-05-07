function hidden_state(name, seconds)
    scripts.ui:info_hidden_update(seconds)
    scripts.ui:navbar_updates(name)
end

if scripts.event_handlers["skrypty/ui/gmcp_handlers/hidden_state.hidden_state.hidden_state"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/ui/gmcp_handlers/hidden_state.hidden_state.hidden_state"])
end

scripts.event_handlers["skrypty/ui/gmcp_handlers/hidden_state.hidden_state.hidden_state"] = registerAnonymousEventHandler("hidden_state", hidden_state)

