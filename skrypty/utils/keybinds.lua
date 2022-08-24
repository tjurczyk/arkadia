ateam.special_follow_bind_beep = false

function scripts.utils.echobind(text, command, hint, functional_key, newline_cnt)
    newline_cnt = newline_cnt or 2
    local c = "<"..scripts.ui:get_bind_color_backward_compatible() .. ">"
    cecho(string.rep("\n", newline_cnt) .. c .. "bind <yellow>" .. scripts.keybind:keybind_tostring(functional_key) .. c .. ": ")
    if type(command) == "function" then
        cechoLink(c .. text, command, hint, true)
    else
        cechoLink(c .. text, function()
            local sep = string.split(text, "[;#]")
            for k, v in pairs(sep) do expandAlias(v, true) end
        end, hint, true)
    end
    cecho("\n\n")
end

function scripts.utils.bind_functional(command, silent, remove_on_new_location)
    scripts.utils.functional_key = command

    if not silent then
        scripts.utils.echobind(command, nil, command, "functional_key", 2)
    end

    if remove_on_new_location then
        scripts.utils.requested_removal_functional_key = true
    end
end

function scripts.utils.bind_functional_call(func, text, remove_on_new_location)
    scripts.utils.functional_key = func

    if text then
        scripts.utils.echobind(text, func, text, "functional_key", 2)
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
        if type(scripts.utils.functional_key) == "function" then
            scripts.utils.functional_key()
        else
            local sep = string.split(scripts.utils.functional_key, "[;#]")
            for k, v in pairs(sep) do
                expandAlias(v, true)
            end
            scripts.utils.functional_key = nil
        end
    end
end

function scripts.utils.bind_functional_team_follow(command, silent)
    if ateam.special_follow_bind_mode == 0 then
        -- it's disabled
        return
    end

    -- check whether the line contains the team leader name
    if ateam.special_follow_bind_mode == 2 then
        scripts.utils.bind_functional(command, silent)
        raiseEvent("ateamTeamFollowBind")
        return
    end

    for k, v in pairs(ateam.team) do
        if type(k) == "number" then
            if ateam and ateam.objs and ateam.objs[k]["team_leader"] and ateam.objs[k]["desc"] ~= nil and string.find(line, ateam.objs[k]["desc"]) then
                scripts.utils.bind_functional(command, silent)
                raiseEvent("ateamTeamFollowBind")
            
                if ateam.special_follow_bind_beep then
                    raiseEvent("playBeep")
                end
            end
        end
    end
end

registerAnonymousEventHandler("amapNewLocation", scripts.utils.remove_functional_if_requested)

