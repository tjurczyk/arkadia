misc.counter = misc.counter or {}
misc.counter2 = misc.counter2 or {}
misc.counter["killed"] = misc.counter["killed"] or {}
misc.counter["killed_amount"] = misc.counter["killed_amount"] or {}
misc.counter["all_kills"] = misc.counter["all_kills"] or 0
misc.counter.killed_amount["JA"] = misc.counter.killed_amount["JA"] or 0

-- counter2
misc.counter2["db_log"] = db:create("countertwolog", {
    countertwolog = {
        year = 0,
        month = 0,
        day = 0,
        hour = "",
        text = "",
        character = "",
        roomId = 0,
        changed = db:Timestamp("CURRENT_TIMESTAMP")
    }
})

misc.counter2["db_daysum"] = db:create("countertwo_daysum", {
    countertwo_daysum = {
        year = 0,
        month = 0,
        day = 0,
        type = "",
        character = "",
        amount = 0,
    }
})

function trigger_func_skrypty_misc_counter_Zabiles()
    if scripts["character_name"] then
        misc.counter2:add_item(matches[2], matches[4])
    end

    misc.counter:add_killed(matches[4], "JA")

    if not misc.improve["improve_start_timestamp"] then
        misc.improve["improve_start_timestamp"] = getEpoch()
    end
    scripts.ui:info_killed_update()
end

function trigger_func_skrypty_misc_counter_team_left()
    misc.counter["team_killed"] = {}
end

function trigger_func_process_kill_for_teammate()
    if ateam.team_names[matches[2]] then
        if not misc.improve["improve_start_timestamp"] then
            misc.improve["improve_start_timestamp"] = getEpoch()
        end
        misc.counter:add_killed(matches[4], matches[2])
        scripts.ui:info_killed_update()
    end
end
