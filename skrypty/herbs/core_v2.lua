function herbs:v2_print_db()
    if not herbs["data"] then
        return
    end

    if not herbs.db or table.size(herbs.db) == 0 then
        cecho("\n <orange>Brak zbudowanej bazy ziol, ")
        cechoPopup("<deep_sky_blue>kliknij tutaj aby zrobic '/ziola_buduj'", { [[expandAlias("/ziola_buduj")]] }, { [[/ziola_buduj]] }, true)
        cecho(" \n\n")
        return
    end

    cecho("\n")
    cecho("------+-------------------------+----------------------------------------------")
    cecho("\n  <light_slate_blue>ile <grey>|        <light_slate_blue>nazwa <grey>           | <light_slate_blue>             dzialanie <grey>                      ")
    cecho("\n------+-------------------------+----------------------------------------------")

    for _, herb_id in pairs(herbs.sorted_herb_ids) do
        local v = herbs.index[herb_id]
        if table.size(v) > 0 then
            local amount = 0
            for i, j in pairs(v) do
                amount = amount + herbs.db[i][herb_id]["amount"]
            end
            local amount_tmp = "    " .. tostring(amount)
            local name_str = string.sub(herb_id .. "                     ", 0, 23)
            local usage_str = string.sub(herbs.herbs_details[herb_id]["details"] .. "                                                                 ", 0, 64)
            cecho("\n<grey>  " .. string.sub(amount_tmp, #amount_tmp - 2, #amount_tmp) .. " | ")
            local clickable_herb_data = herbs:get_clickable_herb_data(herb_id)
            cechoPopup(name_str, clickable_herb_data["herb_actions"], clickable_herb_data["herb_hints"], true)
            cecho(" | ")
            for iii, use_element in pairs(clickable_herb_data["use_elements"]) do
                if use_element["actions"] then
                    cechoPopup(use_element["text"], use_element["actions"], use_element["hints"], true)
                else
                    cecho(use_element["text"])
                end
                if iii < #clickable_herb_data["use_elements"] then
                    cecho(" || ")
                end
                -- add a single space so we don't make the rest of the line clickable
                -- I don't know how to solve it any other way.
            end
            cecho(" ")
        end
    end
    cecho("\n--------------------------------------------------------------------------------\n")

    if table.size(ateam.team_names) > 0 then
        cecho("\n <yellow>Daj ziola<grey>:<pale_green>")
    end
    local idx = 1
    for teammate_name, v in pairs(ateam.team_names) do
        local teammate_clickable_data = herbs:get_clickable_teammate_data(teammate_name)
        cecho(" ")
        cechoPopup("<pale_green>" .. teammate_name, teammate_clickable_data["teammate_actions"], teammate_clickable_data["teammate_hints"], true)
        if idx ~= table.size(ateam.team_names) then
            cecho(" <grey>||")
        end
        idx = idx + 1
    end
    cecho("\n\n")
end

function herbs:v2_print_db_per_bag(full)
    if not herbs.db or table.size(herbs.db) == 0 then
        scripts:print_log("baza ziola niezbudowana, /ziola_buduj")
        return
    end

    cecho("\n")
    cecho("--------------------------- <green>Ziola w twojej bazie<grey> -------------------------------")
    cecho("\n  <light_slate_blue>ile <grey>|        <light_slate_blue>nazwa <grey>            | <light_slate_blue>             dzialanie <grey>                      ")
    cecho("\n--------------------------------------------------------------------------------")
    cecho("\n                                                                                ")

    local bag_id = 1
    for k = 1, herbs.bags_amount do
        local v = herbs.db[k] or {}

        local bag_count = 0
        for kk, vv in pairs(v) do
            bag_count = bag_count + vv["amount"]
        end

        cecho("\n       ")
        local bag_name = "  <LemonChiffon>                  " .. tostring(k) .. ". woreczek<grey> (" .. tostring(bag_count) .. " ziol)"
        cecho(bag_name)

        if herbs.herb_bag_collect_condition_data and herbs.herb_bag_collect_condition_data["bag_id_to_condition"][bag_id] then
            if bag_count == 0 and string.starts(herbs.herb_bag_collect_condition_data["bag_id_to_condition"][bag_id], "<red") then
                cechoPopup(herbs.herb_bag_collect_condition_data["bag_id_to_condition"][bag_id], { [[expandAlias("/ziola_odloz_woreczek ]] .. tostring(k) .. [[")]] }, { "odloz " .. tostring(k) .. ". woreczek" }, true)
                cecho(" ")
            elseif string.starts(herbs.herb_bag_collect_condition_data["bag_id_to_condition"][bag_id], "<red") then
                local this_bag_condition_clickable_data = herbs:get_clickable_bag_condition_data(bag_id)
                cechoPopup(herbs.herb_bag_collect_condition_data["bag_id_to_condition"][bag_id], this_bag_condition_clickable_data.this_bag_actions, this_bag_condition_clickable_data.this_bag_hints, true)
                cecho(" ")
            else
                cecho(herbs.herb_bag_collect_condition_data["bag_id_to_condition"][bag_id])
            end
        end

        cecho("\n")

        if full then
            cecho("\n")
        end

        if full then
            local iter = 1
            for kk, vv in pairs(v) do
                local bag_herb_count = "    " .. tostring(vv["amount"])
                local justified_bag_herb_count = string.sub(bag_herb_count, #bag_herb_count - 2, #bag_herb_count)
                local bag_herb_name = string.sub(vv["name"] .. "                         ", 0, 25)
                cecho("  " .. justified_bag_herb_count .. " | " .. bag_herb_name)

                if iter < table.size(v) then
                    cecho("\n")
                end
                iter = iter + 1
            end
            cecho("\n                                                                                ")
        end
        bag_id = bag_id + 1
        cecho("\n--------------------------------------------------------------------------------\n")
    end

    if not herbs.herb_bag_collect_condition_data then
        cecho("\n <orange>Brak stanow woreczkow, ")
        cechoPopup("<deep_sky_blue>kliknij tutaj aby zrobic '/woreczki_buduj'", { [[expandAlias("/woreczki_buduj")]] }, { [[/woreczki_buduj]] }, true)
        cecho(" \n\n")
    end
end

function herbs:get_clickable_teammate_data(teammate_name)
    local teammate_actions = { "" }
    local teammate_hints = { teammate_name }
    for _, herb_id in pairs(herbs.sorted_herb_ids) do
        local herb_count = herbs.counts[herb_id]

        for k, v in pairs(herbs.settings.get_herb_counts) do
            if v <= herb_count then
                if v == 1 then
                    table.insert(teammate_hints, "daj " .. herb_id)
                    table.insert(teammate_actions, [[expandAlias("/ziola_daj ]] .. teammate_name .. [[ ]] .. herb_id .. [[")]])
                else
                    table.insert(teammate_hints, "daj " .. herb_id .. " " .. tostring(v))
                    table.insert(teammate_actions, [[expandAlias("/ziola_daj ]] .. teammate_name .. [[ ]] .. herb_id .. [[ ]] .. tostring(v) .. [[")]])
                end
            end
        end
    end
    return { teammate_actions = teammate_actions, teammate_hints = teammate_hints }
end

function herbs:get_clickable_herb_data(herb_name)
    local herb_actions = { "expandAlias(\"/ziolo " .. herb_name .. "\")" }
    local herb_hints = { herb_name }

    for k, v in pairs(herbs.settings.get_herb_counts) do
        if v > 1 then
            table.insert(herb_hints, "wez " .. tostring(v))
            table.insert(herb_actions, [[expandAlias("/wezz ]] .. herb_name .. [[ ]] .. v .. [[")]])
        else
            table.insert(herb_hints, "wez")
            table.insert(herb_actions, [[expandAlias("/wezz ]] .. herb_name .. [[")]])
        end
    end

    local this_herb_actions = herbs.data.herb_id_to_use[herb_name]

    if not this_herb_actions then
        return { herb_actions = herb_actions, herb_hints = herb_hints, use_elements = {} }
    end

    local use_elements = {}

    for k, v in pairs(this_herb_actions) do
        local use_element = {}

        if v["action"] and v["action"] ~= "" then
            use_element["text"] = v["action"] .. ": " .. v["effect"]
        else
            use_element["text"] = v["effect"]
        end

        if not v["dont_bind"] and v["action"] ~= nil and v["action"] ~= "" then
            use_element["hints"] = {}
            use_element["actions"] = {}
            table.insert(use_element["hints"], herb_name)
            table.insert(use_element["actions"], "expandAlias(\"/ziolo " .. herb_name .. "\")")
            for kk, current_count in pairs(herbs.settings.use_herb_counts) do
                local use_hint = ""
                local use_action = ""
                if current_count > 1 then
                    use_hint = v["action"] .. " " .. tostring(current_count)
                    use_action = [[expandAlias("/z_]] .. v["action"] .. [[ ]] .. herb_name .. [[ ]] .. current_count .. [[")]]
                else
                    use_hint = v["action"]
                    use_action = [[expandAlias("/z_]] .. v["action"] .. [[ ]] .. herb_name .. [[")]]
                end
                table.insert(use_element["hints"], use_hint)
                table.insert(herb_hints, use_hint)
                table.insert(use_element["actions"], use_action)
                table.insert(herb_actions, use_action)
            end
        end
        table.insert(use_elements, use_element)
    end
    return { herb_actions = herb_actions, herb_hints = herb_hints, use_elements = use_elements }
end

function herbs:get_clickable_bag_condition_data(bag_id)
    local bags_to_repack_k = get_table_n_smallest_elements(herbs.per_bag_herb_counts, 6)
    this_bag_hints = { "woreczek " .. tostring(bag_id) }
    this_bag_actions = { "" }
    for k, v in pairs(bags_to_repack_k) do
        local bag_to = v["key"]
        if not string.starts(herbs.herb_bag_collect_condition_data["bag_id_to_condition"][bag_to], "<red") then
            table.insert(this_bag_hints, "przepakuj do " .. tostring(bag_to) .. ". woreczka")
            table.insert(this_bag_actions, [[expandAlias("/ziola_przepakuj ]] .. tostring(bag_id) .. [[ ]] .. tostring(bag_to) .. [[")]])
        end
        if table.size(this_bag_hints) >= 4 then
            break
        end
    end
    return { this_bag_hints = this_bag_hints, this_bag_actions = this_bag_actions }
end

function herbs:print_herb_bag_conditions()
    cecho("\n    <green>Woreczki i ich stany:\n\n")
    for bag_id, condition in pairs(herbs.herb_bag_collect_condition_data.bag_id_to_condition) do
        local string_bag_id = scripts.id_to_string[bag_id]
        local bag_name_wrapped = string.sub("<LemonChiffon>" .. string_bag_id .. " woreczek<grey> .................................................", 0, 40)
        cecho("  " .. bag_name_wrapped .. " " .. condition .. "\n")
    end

    if herbs.herb_bag_collect_condition_data["do_post_actions"] then
        herbs:do_post_actions()
    end

    disableTrigger("herb_bag_collect_condition")
    herbs.herb_bag_collect_condition_data["do_post_actions"] = nil
end

function herbs:collect_herb_bag_condition(do_post_actions)
    if not mudlet.supports.coroutines then
        return
    end

    herbs["herb_bag_collect_condition_data"] = {}
    herbs.herb_bag_collect_condition_data["current_bag_id"] = 1
    herbs.herb_bag_collect_condition_data["bag_id_to_condition"] = {}
    enableTrigger("herb_bag_collect_condition")
    herbs.herb_bag_collect_condition_data["do_post_actions"] = do_post_actions
    herbs.herb_bag_collect_condition_data["coroutine_id"] = coroutine.create(herbs.coroutine_collect_herb_bag_condition)
    coroutine.resume(herbs.herb_bag_collect_condition_data["coroutine_id"])
end

function herbs:coroutine_collect_herb_bag_condition()
    for i = 1, 200, 1 do
        send("ocen " .. tostring(i) .. ". woreczek")
        coroutine.yield()
        herbs.herb_bag_collect_condition_data["current_bag_id"] = herbs.herb_bag_collect_condition_data["current_bag_id"] + 1
    end
end

function herbs:coroutine_build_db()
    if not mudlet.supports.coroutines then
        return
    end
    herbs["build_db_coroutine_id"] = coroutine.create(herbs._coroutine_build_db)
    coroutine.resume(herbs["build_db_coroutine_id"])
end

function herbs:_coroutine_build_db()
    herbs.db = {}
    herbs.index = {}
    herbs.counts = {}
    local count_trigg = tempRegexTrigger("^(Nie widzisz tu niczego takiego.|Doliczyl.s sie ([a-z ]+) sztuk(|i)\.)$", [[ herbs:building_counted(matches[3]) ]])
    send("policz swoje woreczki")
    coroutine.yield()

    disableTrigger(count_trigg)

    for i = 1, herbs.bags_amount, 1 do
        send("zajrzyj do " .. scripts.id_to_string_biernik[i] .. " woreczka", true)
        coroutine.yield()
        herbs.current_bag_looking = herbs.current_bag_looking + 1
    end

    herbs["build_db_coroutine_id"] = nil
    herbs:herbs_building_done()
    scripts:print_log("Ok, zbudowalem baze ziol", true)
end

