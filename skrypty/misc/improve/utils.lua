function misc.improve:seconds_to_formatted_string(seconds)
    local minutes = math.floor(seconds / 60)
    local minutes_string

    if minutes < 10 then
        minutes_string = "0" .. tostring(minutes)
    else
        minutes_string = tostring(minutes)
    end

    local seconds = math.floor(seconds % 60)

    if seconds < 10 then
        return minutes_string .. ":0" .. tostring(seconds)
    else
        return minutes_string .. ":" .. tostring(seconds)
    end
end
