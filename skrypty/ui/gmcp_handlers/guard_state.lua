function guard_state(name, seconds)
    scripts.ui:info_cover_ready_update(tostring(seconds))
    scripts.ui:navbar_updates(name)
end

if scripts.event_handlers["skrypty/ui/gmcp_handlers/guard_state.guard_state.guard_state"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/ui/gmcp_handlers/guard_state.guard_state.guard_state"])
end

scripts.event_handlers["skrypty/ui/gmcp_handlers/guard_state.guard_state.guard_state"] = registerAnonymousEventHandler("guard_state", guard_state)

