function misc.counter2:add_item(original_text, item)
    local type = misc.counter.utils:get_entry_key(item)

    local hour = getTime(true, "hh:mm:ss")
    local year = getTime(true, "yyyy")
    local month = getTime(true, "MM")
    local day = getTime(true, "dd")

    misc.counter2:add_log(original_text, year, month, day, hour)
    misc.counter2:add_sum(item, year, month, day, type)
end

function misc.counter2:add_log(original_text, year, month, day, hour)
    local ret = db:add(misc.counter2.db_log.counter2_log, {
        year = year,
        month = month,
        day = day,
        text = original_text,
        hour = hour,
        character = scripts.character_name
    })

    if not ret then
        scripts:print_log("Cos poszlo nie tak z zapisem do globalnych zabitych", true)
    end
end

function misc.counter2:add_sum(item, year, month, day, type)
    -- first, update for this type this date
    local retrieved = db:fetch(misc.counter2.db_daysum.counter2_daysum,
        {
            db:eq(misc.counter2.db_daysum.counter2_daysum.year, year),
            db:eq(misc.counter2.db_daysum.counter2_daysum.month, month),
            db:eq(misc.counter2.db_daysum.counter2_daysum.day, day),
            db:eq(misc.counter2.db_daysum.counter2_daysum.character, scripts.character_name),
            db:eq(misc.counter2.db_daysum.counter2_daysum.type, type)
        })


    if not retrieved or table.size(retrieved) == 0 then
        local ret = db:add(misc.counter2.db_daysum.counter2_daysum, {
            year = year,
            month = month,
            day = day,
            type = type,
            amount = 1,
            character = scripts.character_name
        })

        if not ret then
            scripts:print_log("Cos poszlo nie tak z zapisem do globalnych zabitych", true)
        end

    elseif table.size(retrieved) == 1 then
        local update_item = retrieved[1]
        local count = tonumber(update_item["amount"])
        update_item["amount"] = count + 1
        db:update(misc.counter2.db_daysum.counter2_daysum, update_item)

    else
        scripts:print_log("Cos poszlo nie tak z zapisem do globalnych zabitych", true)
        return
    end

    -- now do 'all' (count for day)
    local retrieved = db:fetch(misc.counter2.db_daysum.counter2_daysum,
        {
            db:eq(misc.counter2.db_daysum.counter2_daysum.year, year),
            db:eq(misc.counter2.db_daysum.counter2_daysum.month, month),
            db:eq(misc.counter2.db_daysum.counter2_daysum.day, day),
            db:eq(misc.counter2.db_daysum.counter2_daysum.type, "all")
        })

    if not retrieved or table.size(retrieved) == 0 then
        local ret = db:add(misc.counter2.db_daysum.counter2_daysum, {
            year = year,
            month = month,
            day = day,
            type = "all",
            amount = 1,
            character = scripts.character_name
        })

        if not ret then
            scripts:print_log("Cos poszlo nie tak z zapisem do globalnych zabitych", true)
        end
    elseif table.size(retrieved) == 1 then
        local update_item = retrieved[1]
        local count = tonumber(update_item["amount"])
        update_item["amount"] = count + 1
        db:update(misc.counter2.db_daysum.counter2_daysum, update_item)
    else
        scripts:print_log("Cos poszlo nie tak z zapisem do globalnych zabitych", true)
        return
    end
end

function misc.counter2:show_short()
    if not scripts.character_name then
        scripts:print_log("Korzystanie z bazy zabitych po ustawieniu 'scripts.character_name' w configu")
        return
    end

    local sql_query = "SELECT * FROM counter2_daysum WHERE character=\"" .. scripts.character_name .. "\" AND type!=\"all\" ORDER BY _row_id ASC"
    local retrieved = db:fetch_sql(misc.counter2.db_daysum.counter2_daysum, sql_query)

    local count_dict = {}

    for k, v in pairs(retrieved) do
        if not count_dict[v["type"]] then
            count_dict[v["type"]] = 0
        end

        count_dict[v["type"]] = count_dict[v["type"]] + tonumber(v["amount"])
    end

    cecho("<grey>+---------------------------------------------------------+\n")
    cecho("<grey>|                                                         |\n")
    local name = string.sub(scripts.character_name .. "                    ", 1, 20)
    cecho("<grey>|  POSTAC: <yellow>" .. name .. "<grey>                           |\n")
    cecho("<grey>|                                                         |\n")

    local sum = 0

    for k, v in pairs(count_dict) do
        local name = string.sub(k .. "<grey> ......................", 1, 29)
        local amount = string.sub(tostring(v) .. "       ", 1, 7)
        sum = sum + tonumber(v)
        local line = "<grey>|  <LawnGreen>" .. name .. " <grey>" .. amount .. "                        |\n"
        cecho(line)
    end

    cecho("<grey>|                                                         |\n")
    cecho("<grey>|       ------------------------------------              |\n")
    cecho("<grey>|                                                         |\n")
    local sum_global_str = string.sub(tostring(sum) .. " zabitych           ", 1, 20)
    cecho("<grey>|  <pink>WSZYSTKICH DO TEJ PORY: <LawnGreen>" .. sum_global_str .. "<grey>           |\n")
    cecho("<grey>|                                                         |\n")
    cecho("<grey>+---------------------------------------------------------+\n")
end

function misc.counter2:show_long()
    if not scripts.character_name then
        scripts:print_log("Korzystanie z bazy zabitych po ustawieniu 'scripts.character_name' w configu")
        return
    end

    local sql_query = "SELECT * FROM counter2_daysum WHERE character=\"" .. scripts.character_name .. "\" AND type!=\"all\" ORDER BY _row_id ASC"
    local retrieved = db:fetch_sql(misc.counter2.db_daysum.counter2_daysum, sql_query)

    cecho("<grey>+---------------------------------------------------------+\n")
    cecho("<grey>|                                                         |\n")
    local name = string.sub(scripts.character_name .. "                    ", 1, 20)
    cecho("<grey>|  POSTAC: <yellow>" .. name .. "<grey>                           |\n")
    cecho("<grey>|                                                         |\n")

    local current_date = nil
    local sum = 0
    local global_sum = 0

    for k, v in pairs(retrieved) do
        local this_date = v["year"] .. "/" .. v["month"] .. "/" .. v["day"]

        local date = string.sub(v["year"] .. "/" .. v["month"] .. "/" .. v["day"] .. "     ", 1, 11)
        local type = string.sub(v["type"] .. " ...................................", 1, 23)
        local amount = string.sub(v["amount"] .. "       ", 1, 7)

        if current_date and current_date ~= this_date then
            local sum_str = string.sub(tostring(sum) .. " zabitych        ", 1, 17)
            cecho("<grey>|                                                         |\n")
            cecho("<grey>|  SUMA: <LawnGreen>" .. sum_str .. "<grey>                                |\n")
            cecho("<grey>|                                                         |\n")
            sum = 0
        end

        if this_date ~= current_date then
            cecho("<grey>|  <orange>" .. date .. "<grey>                                            |\n")
            cecho("<grey>|  ----------                                             |\n")
            current_date = this_date
        end

        cecho("<grey>|     - " .. type .. " <LawnGreen>" .. amount .. "                   <grey>|\n")
        sum = sum + tonumber(v["amount"])
        global_sum = global_sum + tonumber(v["amount"])
    end

    local sum_str = string.sub(tostring(sum) .. " zabitych        ", 1, 17)
    cecho("<grey>|                                                         |\n")
    cecho("<grey>|  SUMA: <LawnGreen>" .. sum_str .. "<grey>                                |\n")
    cecho("<grey>|                                                         |\n")
    cecho("<grey>|       ------------------------------------              |\n")
    cecho("<grey>|                                                         |\n")
    local sum_global_str = string.sub(tostring(global_sum) .. " zabitych           ", 1, 20)
    cecho("<grey>|  <pink>WSZYSTKICH DO TEJ PORY: <LawnGreen>" .. sum_global_str .. "<grey>           |\n")
    cecho("<grey>|                                                         |\n")
    cecho("<grey>+---------------------------------------------------------+\n")
end

function misc.counter2:show_logs(year, month, day)
    if not scripts.character_name then
        scripts:print_log("Korzystanie z bazy zabitych po ustawieniu 'scripts.character_name' w configu")
        return
    end

    local sql_query = "SELECT * FROM counter2_log WHERE character=\"" .. scripts.character_name ..
            "\" AND year=\"" .. year .. "\" AND month=\"" .. month ..
            "\" AND day=\"" .. day .. "\" ORDER BY _row_id ASC"
    local retrieved = db:fetch_sql(misc.counter2.db_log.counter2_log, sql_query)

    local date = string.sub(year .. "/" .. month .. "/" .. day .. "     ", 1, 11)

    cecho("<grey>+---------------------------------------------------------+\n")
    cecho("<grey>|                                                         |\n")
    local name = string.sub(scripts.character_name .. "                    ", 1, 20)
    cecho("<grey>|  POSTAC: <yellow>" .. name .. "<grey>                           |\n")
    cecho("<grey>|                                                         |\n")
    cecho("<grey>|  Logi z <LawnGreen>" .. date .. "<grey>                                     |\n")
    cecho("<grey>|                                                         |\n")

    local sum = 0


    for k, v in pairs(retrieved) do
        local text = string.sub(v["text"] .. "                                                       ", 1, 46)
        local hour = string.sub(v["hour"] .. "          ", 1, 8)
        cecho("<grey>|<orange>  " .. hour .. " <grey>" .. text .. "<grey>|\n")
        sum = sum + 1
    end

    local sum_str = string.sub(tostring(sum) .. " zabitych        ", 1, 17)
    cecho("<grey>|                                                         |\n")
    cecho("<grey>|  SUMA: <LawnGreen>" .. sum_str .. "<grey>                                |\n")
    cecho("<grey>|                                                         |\n")
    cecho("<grey>+---------------------------------------------------------+\n")
end

function misc.counter2:reset()
    if not scripts.character_name then
        scripts:print_log("Korzystanie z bazy zabitych po ustawieniu 'scripts.character_name' w configu")
        return
    end

    if not misc.counter2.retried then
        scripts:print_log("Probujesz wykasowac cala baze zabitych, od tego nie ma odwrotu. Aby wykonac, powtorz komende")
        misc.counter2.retried = true
    else
        db:delete(misc.counter2.db_log.counter2_log, db:eq(misc.counter2.db_log.counter2_log.character, scripts.character_name))
        db:delete(misc.counter2.db_daysum.counter2_daysum, db:eq(misc.counter2.db_daysum.counter2_daysum.character, scripts.character_name))
        scripts:print_log("Ok")
    end

    tempTimer(5, function() misc.counter2.retried = nil end)
end

