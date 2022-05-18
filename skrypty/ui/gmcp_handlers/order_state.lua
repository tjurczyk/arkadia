function order_state(name, seconds)
end

function timer_func_skrypty_order_timer()
    local limit = 15
    local dt = getEpoch() - scripts.ui.order_state_epoch
    if dt >= limit then
        stopNamedTimer("arkadia", "order_timer")
        scripts.ui.states_window_nav_states["order_state"] = scripts.ui["states_window_nav_printable_val_map"]["order_state"]["ok"]
        scripts.ui:info_order_ready_update("ok")
    else
        local val = string.format("%.1f", ateam.options.countdown and (limit - dt) or dt)
        scripts.ui.states_window_nav_states["order_state"] = "<red>" .. val
        scripts.ui:info_order_ready_update(val)
    end
    scripts.ui:navbar_updates("order_state")
    raiseEvent("order_state", dt)
end

if scripts.event_handlers["skrypty/ui/gmcp_handlers/order_state.order_state.order_state"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/ui/gmcp_handlers/order_state.order_state.order_state"])
end

scripts.ui.order_state_epoch = 0
scripts.event_handlers["skrypty/ui/gmcp_handlers/order_state.order_state.order_state"] = registerAnonymousEventHandler("order_state", order_state)

registerNamedTimer("arkadia", "order_timer", 0.1, timer_func_skrypty_order_timer, true)
stopNamedTimer("arkadia", "order_timer")
