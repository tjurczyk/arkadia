function check_enemies_func()
    for _, id in pairs(enemies_to_check) do
        if ateam.objs[id]["living"] == true then
            misc.enemy_eq[id] = {}
            misc.currently_checking_enemy = id
            send("ocen ob_" .. id, false)
            coroutine.yield()
        end
    end
    misc:enemies_print_summary()
end

function misc:enemies_print_summary()
    cecho("=============================================\n")
    cecho("         <yellow>P O D S U M O W A N I E\n\n")

    for k, v in pairs(misc.enemy_eq) do
        local obj_to_attack = nil
        if ateam.enemy_op_ids[k] then
            obj_to_attack = ateam.enemy_op_ids[k]
        elseif ateam.normal_ids[k] then
            obj_to_attack = ateam.normal_ids[k]
        else
            obj_to_attack = "ob_" .. k
        end

        cecho(" - <tomato>" .. ateam.objs[k]["desc"] .. "<grey> (/z " .. obj_to_attack .. ")")

        moveCursorEnd()
        local a = selectString("/z " .. obj_to_attack, 1)
        setLink([[expandAlias("/z ]] .. obj_to_attack .. [[")]], "/z " .. obj_to_attack)
        resetFormat()
        echo("\n\n")
        if v["weapon"] then
            cecho(" <orange>Bronie:  ")
            for k, v in pairs(v["weapon"]) do
                local color = "yellow_green"
                if table.contains(scripts.inv.magics_data.magics, string.lower(v)) then
                    color = scripts.inv.magics_color
                end
                if k ~= 1 then
                    cecho("          ")
                end
                cecho(" (" .. tostring(k) .. ") <" .. color .. ">" .. v .. "\n")
            end
        end

        if v["armor"] then
            cecho(" <orange>Zbroje:  ")
            local id = 1
            for k, v in pairs(scripts.utils:extract_string_list(v["armor"])) do
                local color = "yellow_green"
                if table.contains(scripts.inv.magics_data.magics, string.lower(k)) then
                    color = scripts.inv.magics_color
                end
                if id ~= 1 then
                    cecho("          ")
                end

                cecho(" (" .. tostring(id) .. ") <" .. color .. ">" .. k .. "\n")
                id = id + 1
            end
        end

        if v["clothes"] then
            cecho(" <orange>Ubrania: ")
            local id = 1
            for k, v in pairs(scripts.utils:extract_string_list(v["clothes"])) do
                local color = "yellow_green"
                if table.contains(scripts.inv.magics_data.magics, string.lower(k)) then
                    color = scripts.inv.magics_color
                end
                if id ~= 1 then
                    cecho("          ")
                end
                cecho(" (" .. tostring(id) .. ") <yellow_green>" .. k .. "\n")
                id = id + 1
            end
        end

        echo("\n")
    end
    cecho("=============================================\n")
    misc["checking_enemies"] = false
end

function split_weapons(s)
    return string.split(s, " oraz ")
end

