function ateam:switch_all_numbering()
    local msg = ""
    if ateam.all_numbering then
        msg = "Ok, nie bede numerowal nie-wrogow"
        ateam.all_numbering = false
    else
        msg = "Ok, bede numerowal nie-wrogow"
        ateam.all_numbering = true
    end

    scripts:print_log(msg)
end

function ateam:set_ateam_options()
    if ateam.options.team_numbering_mode == "mode2" then
        ateam.next_team_id = "1"
    else
        ateam.next_team_id = "A"
    end
end

function ateam:increase_team_id_counter()
    if ateam.options.team_numbering_mode == "mode2" then
        ateam.next_team_id = tostring(tonumber(ateam.next_team_id) + 1)
    else
        ateam.next_team_id = string.char(string.byte(ateam.next_team_id) + 1)
    end
    if ateam.next_team_id == "Z" then
        registerAnonymousEventHandler("printStatusDone", function()
            ateam:restart_ateam()
        end, true)
    end
end

function ateam:get_team_member_obj_id(teammate_name)
    if not teammate_name then
        return nil
    end

    for k, v in pairs(ateam.team) do
        if type(k) == "number" then
            if ateam.objs[k] and ateam.objs[k]["desc"] == teammate_name then
                return "ob_" .. tostring(k)
            end
        end
    end

    return nil
end

