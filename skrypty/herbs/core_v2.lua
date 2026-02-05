function herbs:v2_init_data()
    herbs["herbs_long_to_short"] = {}
    herbs["herbs_details"] = {}

    if not io.exists(herbs.data_file_path) then
        scripts:print_log("baza ziol niedostepna, skrypt do ziol nie bedzie dzialal")
        return
    end

    local file_handle = assert(io.open(herbs.data_file_path, "r"))
    local file_content = file_handle:read("*all")
    herbs["data"] = yajl.to_value(file_content)
    herbs:v2_init_herbs()
    herbs:create_herbs_category_data()
end

function herbs:v2_init_herbs()
    for herb_name, herb_odmiana in pairs(herbs.data.herb_id_to_odmiana) do
        for _, herb_odmiana_val in pairs(herb_odmiana) do
            herbs.herbs_long_to_short[herb_odmiana_val] = herb_name
        end
    end
    local actions = {}
    for herb_name, herb_actions in pairs(herbs.data.herb_id_to_use) do
        local herb_action_str = ""
        for idx, herb_action in pairs(herb_actions) do
            if not table.contains({ ".", "brak" }, herb_action["action"]) then
                actions[herb_action["action"]] = true
            end
            if herb_action["effect"] ~= nil and herb_action["action"] then
                herb_action_str = herb_action_str .. herb_action["action"] .. ": " .. herb_action["effect"]
            end
            if idx ~= #herb_actions then
                herb_action_str = herb_action_str .. " | "
            end
        end
        herbs.herbs_details[herb_name] = {}
        herbs.herbs_details[herb_name]["desc"] = herbs.data.herb_id_to_odmiana[herb_name]["mianownik"]
        herbs.herbs_details[herb_name]["acc"] = herbs.data.herb_id_to_odmiana[herb_name]["biernik"]
        herbs.herbs_details[herb_name]["details"] = herb_action_str
    end

    if herbs.use_alias then
        killAlias(herbs.use_alias)
    end
    herbs.use_alias = tempAlias(
        string.format("^/z_(%s) ([a-z_]+)(?: ([0-9]+))?$", table.concat(table.keys(actions), "|")),
        "alias_func_skrypty_herbs_zazyj_ziolo()")
end

function herbs:create_herbs_category_data()
    herbs["herbs_categories"] = {
        ["zmeczenie"] = {},
        ["kondycja"] = {},
        ["odtrutki"] = {},
        ["wzmocnienie"] = {},
        ["mana"] = {},
        ["pozostale"] = {}
    }
    herbs["herb_to_categories"] = {}
    herbs["herbs_categories_print_order"] = { "zmeczenie", "kondycja", "mana", "odtrutki", "wzmocnienie", "pozostale" }
    local not_non_primary = { "swietlik", "rosiczka" }

    for herb_name, herbs_details in pairs(herbs.herbs_details) do
        local herb_usage = herbs_details["details"]
        herbs.herb_to_categories[herb_name] = {}
        local none_of_the_primary = true
        if string.find(herb_usage, "-zmc") then
            table.insert(herbs.herbs_categories.zmeczenie, herb_name)
            none_of_the_primary = false
            table.insert(herbs.herb_to_categories[herb_name], "zmeczenie")
        end
        if string.find(herb_usage, "+kon") then
            table.insert(herbs.herbs_categories.kondycja, herb_name)
            none_of_the_primary = false
            table.insert(herbs.herb_to_categories[herb_name], "kondycja")
        end
        if string.find(herb_usage, "odtr") then
            table.insert(herbs.herbs_categories.odtrutki, herb_name)
            none_of_the_primary = false
            table.insert(herbs.herb_to_categories[herb_name], "odtrutki")
        end
        if string.find(herb_usage, "+sil") or string.find(herb_usage, "+wyt") or string.find(herb_usage, "+zrc") or string.find(herb_usage, "+odw") or string.find(herb_usage, "+spo") or string.find(herb_usage, "+int") then
            table.insert(herbs.herbs_categories.wzmocnienie, herb_name)
            none_of_the_primary = false
            table.insert(herbs.herb_to_categories[herb_name], "wzmocnienie")
        end
        if string.find(herb_usage, "+man") then
            table.insert(herbs.herbs_categories.mana, herb_name)
            none_of_the_primary = false
            table.insert(herbs.herb_to_categories[herb_name], "mana")
        end

        if none_of_the_primary == true and not table.contains(not_non_primary, herb_name) then
            table.insert(herbs.herbs_categories.pozostale, herb_name)
            table.insert(herbs.herb_to_categories[herb_name], "pozostale")
        end
    end
    table.insert(herbs.herbs_categories.mana, "rosiczka")
    table.insert(herbs.herbs_categories.kondycja, "przelot")

    table.sort(herbs.herbs_categories.zmeczenie)
    table.sort(herbs.herbs_categories.kondycja)
    table.sort(herbs.herbs_categories.odtrutki)
    table.sort(herbs.herbs_categories.wzmocnienie)
    table.sort(herbs.herbs_categories.mana)
    table.sort(herbs.herbs_categories.pozostale)

    herbs["short_category_to_category"] = {
        zme = "zmeczenie",
        kon = "kondycja",
        man = "mana",
        odt = "odtrutki",
        wzm = "wzmocnienie",
        poz = "pozostale"
    }
end

function herbs:v2_print_db()
    if not herbs["data"] then
        return
    end

    herbs:v2_do_print("main")
    herbs.window:print()
end

function herbs:v2_do_print(window, compact)
    if not herbs.db or table.size(herbs.db) == 0 then
        cecho(window, "\n <orange>Brak zbudowanej bazy ziol, ")
        cechoPopup(window, "<deep_sky_blue>kliknij tutaj aby zrobic '/ziola_buduj'", { [[expandAlias("/ziola_buduj")]] },
            { [[/ziola_buduj]] }, true)
        cecho(window, " \n\n")
        return
    end

    if not compact then
        cecho(window, "\n")
        cecho(window, " ------+-------------------------+-----------------------------------------------")
        cecho(window,
            "\n   <light_slate_blue>ile <grey>|        <light_slate_blue>nazwa <grey>           | <light_slate_blue>             dzialanie <grey>                      ")
        cecho(window, "\n ------+-------------------------+-----------------------------------------------")
        echo(window, "\n")
    end

    for _, herb_id in pairs(herbs.sorted_herb_ids) do
        local v = herbs.index[herb_id]
        if table.size(v) > 0 then
            local amount = 0
            for i, j in pairs(v) do
                amount = amount + herbs.db[i][herb_id]["amount"]
            end
            local amount_tmp = "    " .. tostring(amount)
            local name_str = string.sub(herb_id .. "                     ", 0, 23)
            local usage_str = string.sub(
                herbs.herbs_details[herb_id]["details"] ..
                "                                                                 ", 0, 64)
            cecho(window, "<grey>  " .. string.sub(amount_tmp, #amount_tmp - 2, #amount_tmp) .. " | ")
            local clickable_herb_data = herbs:get_clickable_herb_data(herb_id)
            cechoPopup(window, name_str, clickable_herb_data["herb_actions"], clickable_herb_data["herb_hints"], true)
            cecho(window, " | ")
            for iii, use_element in pairs(clickable_herb_data["use_elements"]) do
                if use_element["actions"] then
                    cechoPopup(window, use_element["text"], use_element["actions"], use_element["hints"], true)
                else
                    cecho(window, use_element["text"])
                end
                if iii < #clickable_herb_data["use_elements"] then
                    cecho(window, " | ")
                end
                -- add a single space so we don't make the rest of the line clickable
                -- I don't know how to solve it any other way.
            end
            cecho(window, "\n")
        end
    end
    if not compact then
        cecho(window, "--------------------------------------------------------------------------------\n")

        if table.size(ateam.team_names) > 0 then
            cecho(window, "\n  <yellow>Daj ziola<grey>:<pale_green>")
        end
        local idx = 1
        for teammate_name, v in pairs(ateam.team_names) do
            local teammate_clickable_data = herbs:get_clickable_teammate_data(teammate_name)
            cecho(window, " ")
            cechoPopup(window, "<pale_green>" .. teammate_name, teammate_clickable_data["teammate_actions"],
                teammate_clickable_data["teammate_hints"], true)
            if idx ~= table.size(ateam.team_names) then
                cecho(window, " <grey>|")
            end
            idx = idx + 1
        end
        cecho(window, "\n\n")
    end
end

function herbs:v2_print_db_per_bag(full)
    if not herbs.db or table.size(herbs.db) == 0 then
        scripts:print_log("baza ziola niezbudowana, /ziola_buduj")
        return
    end

    cecho("\n")
    cecho("--------------------------- <green>Ziola w twojej bazie<grey> -------------------------------")
    cecho(
        "\n  <light_slate_blue>ile <grey>|        <light_slate_blue>nazwa <grey>            | <light_slate_blue>             dzialanie <grey>                      ")
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
        local bag_name = "  <LemonChiffon>                  " ..
            tostring(k) .. ". woreczek<grey> (" .. tostring(bag_count) .. " ziol)"
        cecho(bag_name)

        if herbs.herb_bag_collect_condition_data and herbs.herb_bag_collect_condition_data["bag_id_to_condition"][bag_id] then
            if bag_count == 0 and string.starts(herbs.herb_bag_collect_condition_data["bag_id_to_condition"][bag_id], "<red") then
                cechoPopup(herbs.herb_bag_collect_condition_data["bag_id_to_condition"][bag_id],
                    { [[expandAlias("/ziola_odloz_woreczek ]] .. tostring(k) .. [[")]] },
                    { "odloz " .. tostring(k) .. ". woreczek" }, true)
                cecho(" ")
            elseif string.starts(herbs.herb_bag_collect_condition_data["bag_id_to_condition"][bag_id], "<red") then
                local this_bag_condition_clickable_data = herbs:get_clickable_bag_condition_data(bag_id)
                cechoPopup(herbs.herb_bag_collect_condition_data["bag_id_to_condition"][bag_id],
                    this_bag_condition_clickable_data.this_bag_actions, this_bag_condition_clickable_data.this_bag_hints,
                    true)
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
        cechoPopup("<deep_sky_blue>kliknij tutaj aby zrobic '/woreczki_buduj'", { [[expandAlias("/woreczki_buduj")]] },
            { [[/woreczki_buduj]] }, true)
        cecho(" \n\n")
    end
end

function herbs:v2_print_single(herbs_arr)
    if not herbs_arr then
        error("Wrong input")
    end

    cecho("\n")
    cecho(" --------------------------- <green>Ziola w tym woreczku<grey> -------------------------------")
    cecho(
        "\n   <light_slate_blue>ile <grey>|        <light_slate_blue>nazwa <grey>           | <light_slate_blue>             dzialanie <grey>                      ")
    cecho("\n ------+-------------------------+-----------------------------------------------")
    echo("\n")

    local total_herbs_in_this_bag = 0
    local event_data = { ["total_herbs_count"] = 0, ["herbs"] = {} }
    for herb_id, herb_value in pairs(herbs_arr) do
        local amount = 0
        amount       = herb_value["amount"]
        table.insert(event_data["herbs"], { ["name"] = herb_id, ["amount"] = amount })
        total_herbs_in_this_bag = total_herbs_in_this_bag + amount
        local amount_tmp = "    " .. tostring(amount)
        local name_str = string.sub(herb_id .. "                     ", 0, 23)

        cecho("<grey>  " .. string.sub(amount_tmp, #amount_tmp - 2, #amount_tmp) .. " | ")
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
                cecho(" | ")
            end
            -- add a single space so we don't make the rest of the line clickable
            -- I don't know how to solve it any other way.
        end
        cecho("\n")
    end
    event_data.total_herbs_count = total_herbs_in_this_bag
    cecho("--------------------------------------------------------------------------------\n")
    cecho("  Ilosc ziol w woreczku to <green>" ..
        total_herbs_in_this_bag ..
        "<grey>, a wolne miejsce <green>" .. (herbs["full_bag_amount"] - total_herbs_in_this_bag) .. "\n")
    cecho("--------------------------------------------------------------------------------")
    raiseEvent("herbBagParsed", event_data)
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
                    table.insert(teammate_actions,
                        [[expandAlias("/ziola_daj ]] .. teammate_name .. [[ ]] .. herb_id .. [[")]])
                else
                    table.insert(teammate_hints, "daj " .. herb_id .. " " .. tostring(v))
                    table.insert(teammate_actions,
                        [[expandAlias("/ziola_daj ]] ..
                        teammate_name .. [[ ]] .. herb_id .. [[ ]] .. tostring(v) .. [[")]])
                end
            end
        end
    end
    return { teammate_actions = teammate_actions, teammate_hints = teammate_hints }
end

function herbs:get_clickable_herb_data(herb_name)
    local herb_actions = { "" }
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
            table.insert(use_element["actions"], "")
            for kk, current_count in pairs(herbs.settings.use_herb_counts) do
                local use_hint = ""
                local use_action = ""
                if current_count > 1 then
                    use_hint = v["action"] .. " " .. tostring(current_count)
                    use_action = [[expandAlias("/z_]] ..
                        v["action"] .. [[ ]] .. herb_name .. [[ ]] .. current_count .. [[")]]
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
            table.insert(this_bag_actions,
                [[expandAlias("/ziola_przepakuj ]] .. tostring(bag_id) .. [[ ]] .. tostring(bag_to) .. [[")]])
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
        local bag_name_wrapped = string.sub(
            "<LemonChiffon>" .. bag_id .. ". woreczek<grey> .................................................", 0, 40)
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
        send("ocen " .. tostring(i) .. ". swoj woreczek")
        coroutine.yield()
        herbs.herb_bag_collect_condition_data["current_bag_id"] = herbs.herb_bag_collect_condition_data
            ["current_bag_id"] + 1
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
    local count_trigg = tempRegexTrigger("^(Nie widzisz tu niczego takiego.|Doliczyl.s sie ([a-z ]+) sztuk(|i)\\.)$",
        [[ herbs:building_counted(matches[3]) ]])
    send("policz swoje woreczki")
    coroutine.yield()

    disableTrigger(count_trigg)

    for i = 1, herbs.bags_amount, 1 do
        send("zajrzyj do " .. i .. ". swojego woreczka", true)
        coroutine.yield()
        herbs.current_bag_looking = herbs.current_bag_looking + 1
    end

    herbs["build_db_coroutine_id"] = nil
    herbs:herbs_building_done()
    raiseEvent("herbsDatabaseBuilt")
    scripts:print_log("Ok, zbudowalem baze ziol", true)
end
