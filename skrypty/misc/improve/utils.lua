function misc.improve:seconds_to_formatted_string(seconds)
    local minutes = math.floor(seconds / 60)
    local minutes_string = ""

    if minutes > 60 then
        hours = math.floor(minutes / 60)
        if hours < 10 then
            minutes_string = "0" .. tostring(hours)
        else
            minutes_string = tostring(hours)
        end
        minutes_string = minutes_string .. ":"
        minutes = minutes - (hours * 60)
    end

    if minutes < 10 then
        minutes_string = minutes_string .. "0" .. tostring(minutes)
    else
        minutes_string = minutes_string .. tostring(minutes)
    end

    local seconds = math.floor(seconds % 60)

    if seconds < 10 then
        return minutes_string .. ":0" .. tostring(seconds)
    else
        return minutes_string .. ":" .. tostring(seconds)
    end
end
