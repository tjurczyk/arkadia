function scripts.utils:get_time_string(time1, time2)
    -- time1 and time2 are seconds (From StopWatch)

    local seconds_passed = time2 - time1
    local minutes = math.floor(seconds_passed / 60)
    local minutes_string = nil

    if minutes < 10 then
        minutes_string = "0" .. tostring(minutes)
    else
        minutes_string = tostring(minutes)
    end

    local seconds = math.floor(seconds_passed % 60)

    local ret_str = nil

    if seconds < 10 then
        return minutes_string .. ":0" .. tostring(seconds)
    else
        return minutes_string .. ":" .. tostring(seconds)
    end
end

function seconds_to_clock(seconds)
    local seconds = tonumber(seconds)

    if seconds <= 0 then
        return "0"
    else
        hours = string.format("%02.f", math.floor(seconds / 3600))
        mins = string.format("%01.f", math.floor(seconds / 60 - (hours * 60)))
        secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))
        --newTime = hours..":"..mins..":"..secs

        if seconds < 10 then
            return seconds
        elseif seconds < 60 then
            return secs
        else
            return mins .. ":" .. secs
        end
    end
end


