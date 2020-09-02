function character_gmcp_updater()
    local update_event = false
    for k, v in pairs(gmcp.char.state) do
        if scripts.character.state[k] then
            scripts.character.state[k] = v
            update_event = true
        end
    end

    if update_event then
        raiseEvent("character_state_update")
    end

    scripts.character:check_critical_binds()
end

if scripts.event_handlers["skrypty/character/character_gmcp_updater.gmcp.char.state.character_gmcp_updater"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/character/character_gmcp_updater.gmcp.char.state.character_gmcp_updater"])
end

scripts.event_handlers["skrypty/character/character_gmcp_updater.gmcp.char.state.character_gmcp_updater"] = registerAnonymousEventHandler("gmcp.char.state", character_gmcp_updater)

