-- this loads dump if necessary

function misc_load_dump()
    if scripts.character_name then
        dump = {}
        local name_lowered = string.lower(scripts.character_name)
        if io.exists(getMudletHomeDir() .. "/" .. name_lowered .. "_tmp_data.lua") then
            table.load(getMudletHomeDir() .. "/" .. name_lowered .. "_tmp_data.lua", dump)
        end

        if dump["misc.improve.current_improve_level"] then
            misc.improve["current_improve_level"] = dump["misc.improve.current_improve_level"]
        end

        if dump["misc.improve.level_snapshots"] then
            misc.improve["level_snapshots"] = dump["misc.improve.level_snapshots"]
        end

        if dump["misc.improve.improve_start_timestamp"] then
            misc.improve["improve_start_timestamp"] = dump["misc.improve.improve_start_timestamp"]
        end

        if dump["misc.counter.killed"] then
            misc.counter["killed"] = dump["misc.counter.killed"]
        end

        if dump["misc.counter.killed_amount"] then
            misc.counter["killed_amount"] = dump["misc.counter.killed_amount"]
        end

        if dump["misc.counter.all_kills"] then
            misc.counter["all_kills"] = dump["misc.counter.all_kills"]
        end

        if dump["misc.counter.killed_amount.JA"] then
            misc.counter.killed_amount["JA"] = dump["misc.counter.killed_amount.JA"]
        end

        if misc.counter["all_kills"] > 0 then
            tempTimer(5, function() scripts.ui:info_killed_update() end)
        end
    end
end


