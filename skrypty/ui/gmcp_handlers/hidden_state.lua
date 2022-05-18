function hidden_state(name, seconds)
end

function timer_func_skrypty_hidden_timer()
    local dt = getEpoch() - scripts.ui.hidden_state_epoch
    if dt >= 15 then
        stopNamedTimer("arkadia", "hidden_timer")
        scripts.ui.states_window_nav_states["hidden_state"] = ""
        scripts.ui:info_hidden_update("")
    else
        local val = string.format("%i", dt)
        scripts.ui.states_window_nav_states["hidden_state"] = "<red>" .. val
        scripts.ui:info_hidden_update(val)
    end
    ateam:print_status()
    scripts.ui:navbar_updates("hidden_state")
    raiseEvent("hidden_state", dt)
end

if scripts.event_handlers["skrypty/ui/gmcp_handlers/hidden_state.hidden_state.hidden_state"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/ui/gmcp_handlers/hidden_state.hidden_state.hidden_state"])
end

scripts.ui.hidden_state_epoch = 0
scripts.event_handlers["skrypty/ui/gmcp_handlers/hidden_state.hidden_state.hidden_state"] = registerAnonymousEventHandler("hidden_state", hidden_state)

registerNamedTimer("arkadia", "hidden_timer", 0.1, timer_func_skrypty_hidden_timer, true)
stopNamedTimer("arkadia", "hidden_timer")
