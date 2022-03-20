function gmcp_handler_improvement()
    local improve_level = 0
    for k, v in pairs(gmcp.char.state) do
        if k == "improve" then
            improve_level = tonumber(v)
        end
    end

    if improve_level <= 0 then
        return
    end

    if improve_level == misc.improve.current_improve_level then
        return
    end

    misc.improve.current_improve_level = improve_level

    if misc.improve["improve2_enabled"] and (scripts.character.state.form == 3 or scripts.character.options.values.form == 0 or misc.improve.ignore_form) then
        -- get previous value to know how many to add
        local prev_val = 0

        if table.size(misc.improve["level_snapshots"]) > 0 then
            prev_val = misc.improve.level_snapshots[#misc.improve.level_snapshots]["level"]
        end

        misc.improve:add_improvee2(improve_level - prev_val)
    else
        if not misc.improve["improve2_enabled"] then
            scripts:print_log("Nie zapisuje do globalnych, bo jest wylaczony")
        else
            scripts:print_log("Nie zapisuje do globalnych, z powodu niepelnej formy")
        end
    end

    -- snapshot of killed mobs
    local snapshot = {}
    snapshot["level"] = improve_level
    snapshot["time"] = getTime(true, "dd/MM hh:mm:ss")
    snapshot["timestamp"] = getEpoch()

    local last_snapshot = nil
    if table.size(misc.improve["level_snapshots"]) > 0 then
        last_snapshot = misc.improve["level_snapshots"][#misc.improve["level_snapshots"]]
    end

    snapshot["me_killed"] = misc.counter.killed_amount["JA"]
    snapshot["all_killed"] = misc.counter.all_kills

    local seconds_passed = snapshot["timestamp"] - misc.improve["improve_start_timestamp"]
    misc.improve["improve_start_timestamp"] = getEpoch()
    snapshot["seconds_passed"] = seconds_passed
    snapshot["time_passed"] = misc.improve:seconds_to_formatted_string(seconds_passed)

    table.insert(misc.improve["level_snapshots"], snapshot)
    scripts:print_log(string.format("[%s] Wlasnie %s postepy: %s (czas: %s)", snapshot["time"], scripts.utils.gender_form("wbiles", "wbilas"), misc.improve.levels[improve_level], snapshot["time_passed"]))
    misc_on_exit_dump()
end

if scripts.event_handlers["skrypty/misc/improve/gmcp_handler_improvement.gmcp.char.state.gmcp_handler_improvement"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/misc/improve/gmcp_handler_improvement.gmcp.char.state.gmcp_handler_improvement"])
end

scripts.event_handlers["skrypty/misc/improve/gmcp_handler_improvement.gmcp.char.state.gmcp_handler_improvement"] = registerAnonymousEventHandler("gmcp.char.state", gmcp_handler_improvement)

