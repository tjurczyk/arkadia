function ateam:check_team_here()
    local not_here = {}

    -- first, clean team
    for k, v in pairs(ateam.team) do
        if type(v) == "number" and ateam.objs[v]["team"] == false then
            local letter = ateam.team[v]
            ateam.team[v] = nil
            ateam.team[letter] = nil
        end
    end

    for k, v in pairs(ateam.team) do
        if type(v) == "number" and table_has_value(gmcp.objects.nums, v) == false then
            table.insert(not_here, ateam.objs[v]["desc"])
        end
    end

    if table.size(not_here) == 0 then
        scripts:print_log("Wszyscy sa")
    else
        scripts:print_log("Brakuje: <LawnGreen>" .. table.concat(not_here, ", "))
    end
end

function ateam:can_perform_sneaky_attack()
    if scripts.ui.info_hidden_value == "ok" or
            (tonumber(scripts.ui.info_hidden_value) and tonumber(ateam.sneaky_attack_cond) and tonumber(scripts.ui.info_hidden_value) >= tonumber(ateam.sneaky_attack_cond)) then
        return true
    end
    return false
end

