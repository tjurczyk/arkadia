function weapon_state(name, weapon_state)
    scripts.ui.states_window_nav_states["weapon_state"] = weapon_state
    scripts.ui:info_weapon_update(weapon_state)
    scripts.ui:navbar_updates(name)
end



if scripts.event_handlers["skrypty/ui/gmcp_handlers/weapon_state.weapon_state.weapon_state"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/ui/gmcp_handlers/weapon_state.weapon_state.weapon_state"])
end

scripts.event_handlers["skrypty/ui/gmcp_handlers/weapon_state.weapon_state.weapon_state"] = registerAnonymousEventHandler("weapon_state", weapon_state)

