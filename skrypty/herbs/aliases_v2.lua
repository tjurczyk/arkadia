function herbs:put_herb_bag_down(bag_id)
    sendAll("odbezpiecz " .. tostring(bag_id) .. ". swoj woreczek", "odtrocz " .. tostring(bag_id) .. ". swoj woreczek",
        "odloz " .. tostring(bag_id) .. ". swoj woreczek")
end

function herbs:use_herb(herb_id, action, amount)
    self:use_herbs({ [herb_id] = { action = action, amount = amount } })
end

function herbs:use_herbs(entries)
    if herbs.pre_use then misc:run_separeted_command(herbs.pre_use) end

    for herb_id, entry in pairs(entries) do
        herbs:perform_herb_use(herb_id, entry.action, entry.amount)
    end

    if herbs.post_use then misc:run_separeted_command(herbs.post_use) end
end

function herbs:perform_herb_use(herb_id, herb_action, herb_amount)
    herbs:get_herbs(herb_id, herb_amount)
    local use_herb_command = herb_action
    use_herb_command = use_herb_command .. " " .. herb_amount .. " " .. herbs:get_case(herb_id, herb_amount)
    send(use_herb_command)
end

function herbs:give_herbs_teammate(teammate_name, herb_id, herb_amount)
    local team_member_obj = ateam:get_team_member_obj_id(teammate_name)

    if not team_member_obj then
        scripts:print_log("Nie ma takiego czlonka druzyny")
        return
    end

    if not herbs.data["herb_id_to_odmiana"][herb_id] then
        scripts:print_log("Nie ma takiego ziola")
        return
    end

    herbs:get_herbs(herb_id, herb_amount)

    local command_to_teammate = "daj ziola " .. team_member_obj
    send(command_to_teammate)
end

function herbs:repack_from_to_bag(from_bag, to_bag)
    local string_from_bag = tostring(from_bag)
    local string_to_bag = tostring(to_bag)
    sendAll("otworz " .. string_from_bag .. ". swoj woreczek", "wez ziola z " .. string_from_bag .. ". swojego woreczka",
        "otworz " .. string_to_bag .. ". swoj woreczek", "wloz ziola do " .. string_to_bag .. ". swojego woreczka",
        "otworz " .. string_from_bag .. ". swoj woreczek", "wloz ziola do " .. string_from_bag .. ". swojego woreczka",
        "zamknij otwarte woreczki", true)
end

function herbs:do_pre_actions()
    self.restore = scripts.character.options:set_temporary("parsing_order", 1)
    herbs:do_pre_post_actions("pre")
end

function herbs:do_post_actions()
    herbs:do_pre_post_actions("post")
    self.restore()
end

function herbs:do_pre_post_actions(pre_post)
    local actions = nil
    if pre_post == "pre" then
        actions = herbs.pre_actions
    elseif pre_post == "post" then
        actions = herbs.post_actions
    end
    misc:run_separeted_command(actions)
end

function herbs:print_build_herbs_db_message()
    window = "main"
    cecho(window, "\n <orange>Brak zbudowanej bazy ziol, ")
    cechoPopup(window, "<deep_sky_blue>kliknij tutaj aby zrobic '/ziola_buduj'", { [[expandAlias("/ziola_buduj")]] },
        { [[/ziola_buduj]] }, true)
    cecho(window, " \n\n")
end

function herbs:show_summary(full, one_category)
    local window = "main"
    if not herbs.db or table.size(herbs.db) == 0 then
        herbs:print_build_herbs_db_message()
        return
    end

    cecho(window, "\n")
    cecho(window, " ------+-------------------------+-----------------------------------------------")
    cecho(window,
        "\n   <light_slate_blue>ile <grey>|        <light_slate_blue>nazwa <grey>           | <light_slate_blue>             dzialanie <grey>                      ")
    echo(window, "\n")

    local herbs_categories = herbs.herbs_categories_print_order
    if not full then
        herbs_categories = { "zmeczenie", "kondycja", "mana" }
    end
    if one_category then
        herbs_categories = { herbs.short_category_to_category[one_category] }
    end
    local tmp_total_herbs_in_this_category = ""
    local herbs_total = 0
    local herb_counted = {}

    for _, herb_category in pairs(herbs_categories) do
        local total_herbs_in_this_category = 0

        cecho(window, " ------+-------------------------+-----------------------------------------------")
        cecho(window, "\n                           <yellow>-- " .. herb_category .. " --                      ")
        cecho(window, "\n ------+-------------------------+-----------------------------------------------\n")
        local unique_herbs = 0
        for _, herb_id in pairs(herbs.sorted_herb_ids) do
            local v = herbs.index[herb_id]
            if table.size(v) > 0 and table.contains(herbs.herbs_categories[herb_category], herb_id) then
                unique_herbs = unique_herbs + 1
                local amount = 0
                for i, j in pairs(v) do
                    amount = amount + herbs.db[i][herb_id]["amount"]
                end

                if not herb_counted[herb_id] then
                    herbs_total = herbs_total + amount
                    herb_counted[herb_id] = true
                end
                total_herbs_in_this_category = total_herbs_in_this_category + amount
                local amount_tmp = "    " .. tostring(amount)
                local name_str = string.sub(herb_id .. "                     ", 0, 23)
                local usage_str = string.sub(
                    herbs.herbs_details[herb_id]["details"] ..
                    "                                                                 ", 0, 64)
                cecho(window, "<grey> " .. string.sub(amount_tmp, #amount_tmp - 4, #amount_tmp) .. " | ")
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
        tmp_total_herbs_in_this_category = "    " .. tostring(total_herbs_in_this_category)
        cecho(window, " ------+-------------------------+-----------------------------------------------\n")
        cecho(window,
            "<grey> " ..
            string.sub(tmp_total_herbs_in_this_category, #tmp_total_herbs_in_this_category - 4,
                #tmp_total_herbs_in_this_category) .. " | ")
        local how_many_bags = tonumber(string.format("%.2f", total_herbs_in_this_category / 44))
        local how_many_bags_str = how_many_bags .. " woreczkow                "
        how_many_bags_str = string.sub(how_many_bags_str, 0, 23)
        cecho(window, how_many_bags_str .. " | ")
        cecho(window, tostring(unique_herbs) .. " rodzajow ziol\n")
        -- cecho(window, how_many_bags_str)
    end


    cecho(window, " --------------------------------------------------------------------------------\n")

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
    local bags_count = table.size(herbs.per_bag_herb_counts)
    local bags_total_space = herbs.full_bag_amount * bags_count
    local remaining_space = bags_total_space - herbs_total
    local remaining_space_bags = string.format("%.2f", remaining_space / herbs.full_bag_amount)
    local bags_full_percentage = 0
    if bags_total_space > 0 then
        bags_full_percentage = herbs_total / (bags_total_space) * 100
    end
    bags_full_percentage = string.format("%.2f", bags_full_percentage)
    if full then
        cecho(window,
            "\n     <light_slate_blue>Woreczkow w bazie: <yellow>" ..
            tostring(table.size(herbs.per_bag_herb_counts)) .. "\n")
        cecho(window,
            "     <light_slate_blue>Liczba ziol w woreczkach: <yellow>" ..
            tostring(herbs_total) .. " (" .. bags_full_percentage .. "% pojemnosci)\n")
        cecho(window,
            "     <light_slate_blue>Wolne miejsce w woreczkach: <yellow>" ..
            tostring(remaining_space) .. " (" .. remaining_space_bags .. " woreczkow)\n")
        cecho(window, "\n --------------------------------------------------------------------------------\n")
    end
end
