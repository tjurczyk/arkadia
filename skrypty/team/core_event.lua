ateam.event = ateam.event or { me_attacked = false, team_attacked = false }

function ateam_gmcp_post_checks()
    --ateam:sneaky_checker()
    ateam:team_checker()
end

function ateam:team_checker()
    -- check if i am being attacked

    if ateam.my_id then
        if ateam.objs[ateam.my_id]["attack_num"] ~= false and ateam.event.me_attacked == false then
            ateam.event.me_attacked = true
            raiseEvent("ateam_am_attacked", true)
        elseif ateam.objs[ateam.my_id]["attack_num"] == false and ateam.event.me_attacked ~= false then
            ateam.event.me_attacked = false
            raiseEvent("ateam_am_attacked", false)
        end
    end

    local team_no_attacked_count = 0
    local team_on_location_count = 0

    for k, v in pairs(gmcp.objects.nums) do
        if ateam.objs[v] and ateam.objs[v]["team"] then
            team_on_location_count = team_on_location_count + 1
            if ateam.objs[v]["attack_num"] ~= false and ateam.event.team_attacked == false then
                ateam.event.team_attacked = true
                raiseEvent("ateam_teammate_attacked", true)
            end
            if ateam.objs[v]["attack_num"] == false then
                team_no_attacked_count = team_no_attacked_count + 1
            end
        end
    end

    if ateam.event.team_attacked and team_no_attacked_count == team_on_location_count then
        ateam.event.team_attacked = false
        raiseEvent("ateam_teammate_attacked", false)
    end
end

registerAnonymousEventHandler("gmcp_parsing_finished", "ateam_gmcp_post_checks")


