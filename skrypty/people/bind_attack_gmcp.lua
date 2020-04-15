function bind_attack_gmcp()
    local id = 1
    local already_seen = {}

    if scripts.people.keep_binds_unchanged then
        for k, v in pairs(scripts.people.bind_attack_objs) do
            if gmcp.objects.data[tostring(v)] and gmcp.objects.data[tostring(v)]["desc"] then
                if scripts.people.show_binds_setting > 1 then
                    _show_bind_msg(k, gmcp.objects.data[tostring(v)]["desc"])
                end
                already_seen[v] = true
            end
            if v == -1 then
                break
            end
        end

        -- find first available id
        for k, v in pairs(scripts.people.bind_attack_objs) do
            if v == -1 then
                id = k
                break
            end
            id = id + 1
        end
    end

    for k, v in pairs(gmcp.objects.data) do
        if v["desc"] and (scripts.people.enemy_suffix[v["desc"]] or scripts.people.enemy_suffix[string.lower(v["desc"])]) then
            if scripts.people.bind_attack_objs and id <= table.size(scripts.people.bind_attack_objs) and already_seen[tonumber(k)] ~= true then
                scripts.people.bind_attack_objs[id] = tonumber(k)
                if scripts.people.show_binds_setting > 0 then
                    _show_bind_msg(id, v["desc"])
                end
                id = id + 1
            end
        end
    end
end

function _show_bind_msg(id, desc)
    cecho("\n<tomato>   " .. scripts.keybind:keybind_tostring("attack_bind_objs_" .. tostring(id)) .. " ATAKUJ: " .. desc .. "\n")
end

function show_attack_binds()
    for k, v in pairs(scripts.people.bind_attack_objs) do
        if k == 1 and v == -1 then
            scripts:print_log("Brak zbindowanych osob")
        elseif v == -1 then
            break
        end

        if ateam.objs[v] and ateam.objs[v]["desc"] then
            _show_bind_msg(k, ateam.objs[v]["desc"])
        end
    end
end

function attack_binds_reset()
    scripts.people:build_bind_table()
    scripts:print_log("Bindy na atak zresetowane")
end

if scripts.event_handlers["skrypty/people/bind_attack_gmcp.gmcp.objects.data.bind_attack_gmcp"] then
    killAnonymousEventHandler(scripts.event_handlers["skrypty/people/bind_attack_gmcp.gmcp.objects.data.bind_attack_gmcp"])
end

scripts.event_handlers["skrypty/people/bind_attack_gmcp.gmcp.objects.data.bind_attack_gmcp"] = registerAnonymousEventHandler("gmcp.objects.data", bind_attack_gmcp)

