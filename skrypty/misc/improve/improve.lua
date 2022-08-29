function misc.improve:print_improve()
    local time = getTime(true, "dd/MM hh:mm:ss")
    local average = self:calculate_average()
    local average_str = "             "
    if average > 0 then
        average_str = " : sred " .. misc.improve:seconds_to_formatted_string(average)
    end

    local today = string.split(getTime(true, "yyyy MM dd"), " ")
    local sql_query = "SELECT val FROM improvee WHERE character='" .. scripts.character_name .. "' and year = "..today[1].." and month = "..today[2].." and day = "..today[3].." ORDER BY _row_id ASC"
    local retrieved = db:fetch_sql(misc.improve.db_improvee.improvee, sql_query)
    local value = table.size(retrieved) > 0 and retrieved[1]["val"] or 0

    local postepy_suma = "Dzisiaj: "..value

    cecho("+---------------------------------- <green>Postepy<grey> ---------------------------------+\n")
    cecho("|                                                                            |\n")
    cecho("| <yellow>Aktualny czas   : " .. time .. "<grey>   " .. scripts.utils.str_pad(average_str, 20) .. postepy_suma .. string.rep(" ", 20-string.len(postepy_suma)) .."|\n")
    cecho("|                                                                            |\n")

    local sum_me_killed = 0
    local sum_all_killed = 0
    local last_time_stamp = misc.improve["improve_start_timestamp"]

    for k, v in pairs(misc.improve["level_snapshots"]) do
        local when_got = string.sub(v["time"] .. "                    ", 1, 18)
        sum_me_killed = v["me_killed"]
        sum_all_killed = v["all_killed"]

        -- fix timestamp if /expstart was used
        if k > 1 and misc.improve.level_snapshots[k]["timestamp"] < misc.improve.level_snapshots[k - 1]["timestamp"] then
            misc.improve.level_snapshots[k]["timestamp"] = misc.improve.level_snapshots[k - 1]["timestamp"] + misc.improve.level_snapshots[k]["timestamp"]
        end

        last_time_stamp = v.timestamp
        local time_str = v["time_passed"]

        local killed_str = nil
        if k == 1 then
            killed_str = tostring(v["me_killed"]) .. "/" .. tostring(v["all_killed"])
        else
            killed_str = tostring(v["me_killed"] - misc.improve.level_snapshots[k - 1]["me_killed"]) .. "/" .. tostring(v["all_killed"] - misc.improve.level_snapshots[k - 1]["all_killed"])
        end

        local name = string.sub(misc.improve["levels"][v["level"]] .. "                ", 1, 16)
        local sep = ": "
        local details_time = string.sub("czas " .. time_str .. "                ", 1, 14)
        local details_killed = string.sub(" zabici " .. killed_str .. "                ", 1, 14)

        cecho("| " .. scripts.utils.str_pad(tostring(k), 2, "right") .. ". " .. name .. sep .. when_got .. sep .. details_time .. sep .. details_killed .. "   |\n")
    end

    local since_last_str = nil;
    if last_time_stamp then
        local seconds_since_last = getEpoch() - last_time_stamp
        since_last_str = string.format("Od ostatniego postepu: %s : zabici: %s/%s",
                misc.improve:seconds_to_formatted_string(seconds_since_last),
                tostring(misc.counter.killed_amount["JA"] - sum_me_killed),
                tostring(misc.counter.all_kills - sum_all_killed))
    end

    cecho("|                                                                            |\n")
    cecho("| <orange>ZABITYCH<grey>                                                                   |\n")
    cecho("| <LawnGreen>JA<grey> ... : <orange>" .. string.sub(tostring(sum_me_killed) .. "      ", 1, 6) .. "<grey>                                                            |\n")
    cecho("| <LawnGreen>WSZYSCY<grey>: <orange>" .. string.sub(tostring(sum_all_killed) .. "      ", 1, 6) .. "<grey>                                                            |\n")
    cecho("|                                                                            |\n")

    if since_last_str then
        cecho("| <SlateBlue>".. string.sub(since_last_str .."                                ", 1, 74) .. " <reset>|\n")
        cecho("|                                                                            |\n")
    end
    cecho("+----------------------------------------------------------------------------+\n")

end

function misc.improve:calculate_average()
    local sum_of_time = 0
    for k, v in pairs(misc.improve["level_snapshots"]) do
        if v.seconds_passed == nil then
            return 0
        end
        sum_of_time = sum_of_time + v.seconds_passed
    end
    return math_round(sum_of_time / table.size(misc.improve["level_snapshots"]))
end

function misc.improve:improve_reset()
    misc.improve["current_improve_level"] = 0

    if gmcp and gmcp.char and gmcp.char.state then
        for k, v in pairs(gmcp.char.state) do
            if k == "improve" then
                misc.improve["current_improve_level"] = tonumber(v)
            end
        end
    end

    misc.improve["level_snapshots"] = {}
    misc.improve["improve_start_timestamp"] = getEpoch()
    scripts:print_log("Licznik zresetowany")
end

