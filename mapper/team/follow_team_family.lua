function trigger_func_mapper_team_follow_team_family_follow_team()
    if amap.polish_to_english[matches[4]] then
        amap.dir_from_team_follow = amap.polish_to_english[matches[4]]
    else
        return
    end

    --echo ("GOt dir: " .. amap.dir_from_team_follow .. "\n")
    --amap["queue"] = get_new_list()
    local found = amap:follow(amap.dir_from_team_follow, true)

    if not found then
        amap:follow(matches[3], true)
    end
end

function trigger_func_mapper_team_follow_team_family_special()
    local sep = string.split(matches[3], " ")
    local last = sep[#sep]
    local one_to_last = sep[#sep - 1]

    if amap.polish_to_english[last] and one_to_last == "na" then
        return
    end

    amap.dir_from_team_follow = matches[3]
    amap:follow(amap.dir_from_team_follow, true)
end

function trigger_func_mapper_non_standard_follows(direction)
    amap.dir_from_team_follow = amap.polish_to_english[direction] or direction
    amap:follow(amap.dir_from_team_follow, true)
end
