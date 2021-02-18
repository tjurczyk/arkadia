function misc.counter:add_killed(key, person)
    local l_key = misc.counter.utils:get_entry_key(key)

    -- add entry for this person if necessary
    if not misc.counter.killed[person] then
        misc.counter.killed[person] = {}
        misc.counter.killed_amount[person] = 0
    end

    -- Add key if necessary or increment counter
    if misc.counter.killed[person][l_key] then
        misc.counter.killed[person][l_key] = misc.counter.killed[person][l_key] + 1
    else
        misc.counter.killed[person][l_key] = 1
    end

    misc.counter.killed_amount[person] = misc.counter.killed_amount[person] + 1
    misc.counter.all_kills = misc.counter.all_kills + 1
end

function misc.counter:print_killed()
    local per_type_count = misc.counter:calculate_per_type_sums()
    cecho("+-------------- <green>Licznik zabitych<grey> ---------------+\n")
    cecho("|                                               |\n")

    local all_sum = 0

    if misc.counter.killed["JA"] then
        cecho("| <yellow>JA<grey>                                            |\n")

        local summed = 0
        for k, v in spairs(misc.counter.killed["JA"]) do
            local name = string.sub(k .. " ...............................", 0, 32)
            local color = misc.counter.utils:is_rare(name) and "<orange>" or ""

            local amount = tostring(v) .. " / " .. tostring(per_type_count[k])
            cecho("| " .. color .. name .. " " .. string.sub(amount .. "            ", 0, 12) .. " <grey>|\n")
            summed = summed + v
        end
        all_sum = all_sum + summed
        cecho("|                                               |\n")
        cecho("| <light_slate_blue>LACZNIE<grey>: ....................... " .. string.sub(summed .. "            ", 0, 12) .. " |\n")
    end

    cecho("|                                               |\n")

    for k, v in pairs(misc.counter.killed) do
        if k ~= "JA" then
            local str_name = string.sub(k .. "<grey>                                           ", 0, 52)
            cecho("| <yellow>" .. str_name .. "|\n")

            local summed = 0
            for i, j in spairs(v) do
                local name = string.sub(i .. " ..............................", 0, 32)
                local color = misc.counter.utils:is_rare(name) and "<orange>" or ""

                local amount = tostring(j) .. " / " .. tostring(per_type_count[i])
                cecho("| " .. color .. name .. " " .. string.sub(amount .. "            ", 0, 12) .. " <grey>|\n")
                summed = summed + j
            end
            cecho("|                                               |\n")
            cecho("| <light_slate_blue>LACZNIE<grey>: ....................... " .. string.sub(summed .. "            ", 0, 12) .. " |\n")
            cecho("|                                               |\n")
            all_sum = all_sum + summed
        end
    end
    if table.size(misc.counter.killed) > 0 then
        cecho("|                                               |\n")
        cecho("| <light_slate_blue>DRUZYNA LACZNIE<grey>: ............... " .. string.sub(all_sum .. "            ", 0, 12) .. " |\n")
        cecho("|                                               |\n")
        cecho("+-----------------------------------------------+\n")
    else
        cecho("+-----------------------------------------------+\n")
    end
end

function misc.counter:calculate_per_type_sums()
    local per_type_count = {}
    for char, di in pairs(misc.counter.killed) do
        for monster, amount in pairs(di) do
            if not per_type_count[monster] then
                per_type_count[monster] = amount
            else
                per_type_count[monster] = per_type_count[monster] + amount
            end
        end
    end
    return per_type_count
end

function misc.counter:reset()
    misc.counter.killed = {}
    misc.counter.killed_amount = {}
    misc.counter.killed_amount["JA"] = 0
    misc.counter.all_kills = 0
    scripts:print_log("Licznik zresetowany")
end

