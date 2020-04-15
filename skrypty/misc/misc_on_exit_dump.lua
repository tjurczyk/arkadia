-- perform a full backup:
--  - improve
--  - counter

function misc_on_exit_dump()
    dump = {}
    dump["misc.improve.current_improve_level"] = misc.improve["current_improve_level"]
    dump["misc.improve.level_snapshots"] = misc.improve["level_snapshots"]
    dump["misc.improve.improve_start_timestamp"] = misc.improve["improve_start_timestamp"]
    dump["misc.counter.killed"] = misc.counter["killed"]
    dump["misc.counter.killed_amount"] = misc.counter["killed_amount"]
    dump["misc.counter.all_kills"] = misc.counter["all_kills"]
    dump["misc.counter.killed_amount.JA"] = misc.counter.killed_amount["JA"]

    if scripts.character_name then
        local name_lowered = string.lower(scripts.character_name)
        table.save(getMudletHomeDir() .. "/" .. name_lowered .. "_tmp_data.lua", dump)
    end
end

function misc_clear_dump()
    dump = {}
    if scripts.character_name then
        local name_lowered = string.lower(scripts.character_name)
        table.save(getMudletHomeDir() .. "/" .. name_lowered .. "_tmp_data.lua", dump)
    end
end

if scripts.event_handlers["skrypty/misc/misc_on_exit_dump.sysExitEvent.misc_on_exit_dump"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/misc/misc_on_exit_dump.sysExitEvent.misc_on_exit_dump"])
end

scripts.event_handlers["skrypty/misc/misc_on_exit_dump.sysExitEvent.misc_on_exit_dump"] = registerAnonymousEventHandler("sysExitEvent", misc_on_exit_dump)

if scripts.event_handlers["skrypty/misc/misc_on_exit_dump.sysDisconnectionEvent.misc_on_exit_dump"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/misc/misc_on_exit_dump.sysDisconnectionEvent.misc_on_exit_dump"])
end

scripts.event_handlers["skrypty/misc/misc_on_exit_dump.sysDisconnectionEvent.misc_on_exit_dump"] = registerAnonymousEventHandler("sysDisconnectionEvent", misc_on_exit_dump)

