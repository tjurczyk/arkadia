function order_state(name, seconds)
    scripts.ui:info_order_ready_update(tostring(seconds))
    scripts.ui:navbar_updates(name)
end

if scripts.event_handlers["skrypty/ui/gmcp_handlers/order_state.order_state.order_state"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/ui/gmcp_handlers/order_state.order_state.order_state"])
end

scripts.event_handlers["skrypty/ui/gmcp_handlers/order_state.order_state.order_state"] = registerAnonymousEventHandler("order_state", order_state)

