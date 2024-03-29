function guard_state(name, seconds)
end

function timer_func_skrypty_cover_timer()
    local limit = 5
    local dt = getEpoch() - scripts.ui.guard_state_epoch
    if dt >= limit then
        stopNamedTimer("arkadia", "cover_timer")
        scripts.ui.states_window_nav_states["guard_state"] = false
        scripts.ui:info_cover_ready_update("ok")
    else
        local val = string.format("%.1f", ateam.options.countdown and (limit - dt) or dt)
        scripts.ui.states_window_nav_states["guard_state"] = "<red>" .. val
        scripts.ui:info_cover_ready_update(val)
    end
    scripts.ui:navbar_updates("guard_state")
    raiseEvent("guard_state", dt)
end

if scripts.event_handlers["skrypty/ui/gmcp_handlers/guard_state.guard_state.guard_state"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/ui/gmcp_handlers/guard_state.guard_state.guard_state"])
end

scripts.ui.guard_state_epoch = 0
scripts.event_handlers["skrypty/ui/gmcp_handlers/guard_state.guard_state.guard_state"] = registerAnonymousEventHandler("guard_state", guard_state)

registerNamedTimer("arkadia", "cover_timer", 0.1, timer_func_skrypty_cover_timer, true)
stopNamedTimer("arkadia", "cover_timer")
