function scripts.utils.bind_functional(command, silent, remove_on_new_location)
    scripts.utils.functional_key = command

    if not silent then
        cecho("\n\n" .. scripts.ui.bind_color .. "bind <yellow>" .. scripts.keybind:keybind_tostring("functional_key") .. scripts.ui.bind_color .. ": " .. command .. "\n\n")
    end

    if remove_on_new_location then
        scripts.utils.requested_removal_functional_key = true
    end
end

function scripts.utils.remove_functional_if_requested()
    if scripts.utils.requested_removal_functional_key then
        scripts.utils.functional_key = nil
        scripts.utils.requested_removal_functional_key = false
    end
end

function scripts.utils.execute_functional()
    if scripts.utils.functional_key then
        local sep = string.split(scripts.utils.functional_key, ";")
        for k, v in pairs(sep) do
            expandAlias(v, true)
        end
        scripts.utils.functional_key = nil
    end
end

function scripts.utils.bind_functional_team_follow(line, command, delay, silent)
    if ateam.special_follow_bind_mode == 0 then
        -- it's disabled
        return
    end

    -- check whether the line contains the team leader name
    if not line or ateam.special_follow_bind_mode == 2 then
        scripts.utils.bind_functional(command, silent)
        raiseEvent("ateamTeamFollowBind")
        return
    end

    for k, v in pairs(ateam.team) do
        if type(k) == "number" then
            if ateam and ateam.objs and ateam.objs[k]["team_leader"] and string.find(line, ateam.objs[k]["desc"]) then
                scripts.utils.bind_functional(command, silent)
                raiseEvent("ateamTeamFollowBind")
            end
        end
    end
end

registerAnonymousEventHandler("amapNewLocation", scripts.utils.remove_functional_if_requested)

