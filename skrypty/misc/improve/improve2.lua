function misc.improve:add_improvee2(val)
    if not scripts.character_name then
        scripts:print_log("Korzystanie z globalnej bazy postepow po ustawieniu 'scripts.character_name' w configu")
        return
    end

    local hour = getTime(true, "hh:mm:ss")
    local year = getTime(true, "yyyy")
    local month = getTime(true, "MM")
    local day = getTime(true, "dd")

    local entry = db:fetch(misc.improve.db_improvee.improvee, {
        db:eq(misc.improve.db_improvee.improvee.year, year),
        db:eq(misc.improve.db_improvee.improvee.month, month),
        db:eq(misc.improve.db_improvee.improvee.day, day),
        db:eq(misc.improve.db_improvee.improvee.character, scripts.character_name)
    })

    local ret = true

    if entry and table.size(entry) == 1 then
        entry = entry[1]
        entry["val"] = entry["val"] + val
    elseif table.size(entry) > 1 then
        scripts:print_log("Cos poszlo nie tak z baza")
        return
    else
        ret = db:add(misc.improve.db_improvee.improvee, {
            year = year,
            month = month,
            day = day,
            val = val,
            hour = hour,
            character = scripts.character_name
        })
        if ret then
            scripts:print_log("Ok, dodane do globalnego licznika")
        else
            scripts:print_log("Cos poszlo nie tak z zapisem do globalnych postepow")
        end
        return
    end

    if not db:update(misc.improve.db_improvee.improvee, entry) then
        ret = false
    end

    if not ret then
        scripts:print_log("Cos poszlo nie tak z zapisem do globalnych postepow")
    else
        scripts:print_log("Ok, dodane " .. tostring(val) .. " postepow do globalnego licznika")
    end
end

function misc.improve:print_improvee2()
    if not scripts.character_name then
        scripts:print_log("Korzystanie z bazy postepow po ustawieniu 'scripts.character_name' w configu")
        return
    end

    local sql_query = "SELECT * FROM improvee WHERE character=\"" .. scripts.character_name .. "\" ORDER BY _row_id ASC"
    local retrieved = db:fetch_sql(misc.improve.db_improvee.improvee, sql_query)

    cecho("<grey>+---------------------------------------------------------+\n")
    cecho("<grey>|                                                         |\n")
    local name = string.sub(scripts.character_name .. "                    ", 1, 20)
    cecho("<grey>|  POSTAC: <yellow>" .. name .. "<grey>                           |\n")
    cecho("<grey>|                                                         |\n")

    local sum = 0

    for k, v in pairs(retrieved) do
        local id = string.sub("    " .. v["_row_id"], -4)
        local this_date = v["year"] .. "/" .. v["month"] .. "/" .. v["day"]
        local date = string.sub(v["year"] .. "/" .. v["month"] .. "/" .. v["day"] .. "     ", 1, 11)
        local val_str = ""
        local value = v["val"]

        if value > 0 then
        
            sum = sum + value
            if value > 15 then
                local full = math.floor(value / 15)
                local extra = value % 15
                val_str = string.sub(tostring(full) .. " niebotycznych + " .. tostring(misc.improve.levels[extra]) .. "<grey>                           ", 1, 41) .. "|"
            else
                val_str = string.sub(misc.improve.levels[value] .. "                                ", 1, 35) .. "|"
            end
            
            cecho("| [<antique_white>" .. id .. "<grey>] <orange>" .. date .. "<grey> - <antique_white>" .. val_str .. "\n")
        else
            debugc('BLAD - postepy mniejsze niz zero dla id =' .. id)
        end
    end

    cecho("<grey>|                                                         |\n")
    cecho("<grey>|                                                         |\n")
    cecho("<grey>|       ------------------------------------              |\n")
    cecho("<grey>|                                                         |\n")
    local sum_global_str = string.sub(tostring(sum) .. " postepow" .. "           ", 1, 20)
    cecho("<grey>|  <pink>WSZYSTKICH DO TEJ PORY: <LawnGreen>" .. sum_global_str .. "<grey>           |\n")
    local niebot_str = string.sub("~" .. string.format("%.2f", sum / 15) .. " niebotycznych           ", 1, 20)
    cecho("<grey>|                          <LawnGreen>" .. niebot_str .. "<grey>           |\n")
    cecho("<grey>|                                                         |\n")
    cecho("<grey>+---------------------------------------------------------+\n")
end

function misc.improve:remove_improvee2(id)
    if not scripts.character_name then
        scripts:print_log("Korzystanie z bazy postepow po ustawieniu 'scripts.character_name' w configu")
        return
    end

    local sql_query = "SELECT * FROM improvee WHERE character=\"" .. scripts.character_name ..
            "\" AND _row_id=\"" .. id .. "\" ORDER BY _row_id ASC"
    local retrieved = db:fetch_sql(misc.improve.db_improvee.improvee, sql_query)

    if db:delete(misc.improve.db_improvee.improvee, retrieved[1]) then
        scripts:print_log("Ok")
    else
        scripts:print_log("Problem z baza")
    end
end

function misc.improve:remove_improvee2_val(id, val)
    local sql_query = "SELECT * FROM improvee WHERE character=\"" .. scripts.character_name .. "\" AND _row_id=\"" .. id .. "\" ORDER BY _row_id desc LIMIT 1"
    local retrieved = db:fetch_sql(misc.improve.db_improvee.improvee, sql_query)
    if table.getn(retrieved) == 1 then
        retrieved = retrieved[1]
        retrieved.val = math.max(0, retrieved.val - val)
        if not db:update(misc.improve.db_improvee.improvee, retrieved) then
            scripts:print_log("Cos poszlo nie tak z zapisem do globalnych postepow")
        else
            scripts:print_log("Ok, usunięte z globalnego licznika")
        end
    end
end

function misc.improve:reset_improvee2()
    if not scripts.character_name then
        scripts:print_log("Korzystanie z bazy postepow po ustawieniu 'scripts.character_name' w configu")
        return
    end

    if not misc.improve.retried then
        scripts:print_log("Probujesz wykasowac cala baze postepow, od tego nie ma odwrotu. Aby wykonac, powtorz komende")
        misc.improve.retried = true
    else
        db:delete(misc.improve.db_improvee.improvee, db:eq(misc.improve.db_improvee.improvee.character, scripts.character_name))
        scripts:print_log("Ok")
    end

    tempTimer(5, function() misc.improve.retried = nil end)
end

