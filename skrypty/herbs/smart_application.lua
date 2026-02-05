herbs['smart_application_skip_kon'] = herbs['smart_application_skip_kon'] or {}
herbs['smart_application_skip_man'] = herbs['smart_application_skip_man'] or {}
herbs['smart_application_skip_zme'] = herbs['smart_application_skip_zme'] or { deliona = true }

function herbs:init_smart_application()
    scripts.event_register:kill_event_handler(herbs['smart_application_db_built_init_handler'])
    herbs['smart_application_db_built_init_handler'] = scripts.event_register:force_register_event_handler(
        herbs['smart_application_db_built_init_handler'], "herbsDatabaseBuilt",
        function() herbs:reset_smart_application_queue() end)

    herbs:reset_smart_application_queue()
    herbs['smart_application_action'] = {
        kon = {},
        man = {},
        zme = {}
    }

    for htype, _ in pairs(herbs['smart_application_action']) do
        local prop_category = herbs.short_category_to_category[htype]

        local htype_str_to_search = "+kon"
        if htype == "zme" then
            htype_str_to_search = "-zmc"
        elseif htype == "man" then
            htype_str_to_search = "+man"
        end

        for __, herb in pairs(herbs.herbs_categories[prop_category]) do
            for ___, action in pairs(herbs.data.herb_id_to_use[herb]) do
                if action ~= nil and string.find(action.effect, htype_str_to_search) then
                    herbs.smart_application_action[htype][herb] = action.action
                    break
                end
            end
        end
    end
end

function herbs:reset_smart_application_queue()
    herbs['smart_application_queue'] = {
        kon = { herbs = {}, index = 0 },
        man = { herbs = {}, index = 0 },
        zme = { herbs = {}, index = 0 },
    }
end

function herbs:smart_application_execute(htype)
    if table.size(herbs.smart_application_queue[htype].herbs) == 0 then
        herbs:smart_application_init_htype_queue(htype)
    end

    herbs:smart_application_htype_queue_pretty_msg(htype)
    local taking_herb = herbs.smart_application_queue[htype].herbs[herbs.smart_application_queue[htype].index]
    local action = herbs.smart_application_action[htype][taking_herb]
    -- cecho(" <CadetBlue>aplikuje " .. taking_herb)
    cecho(string.format(" <CadetBlue>aplikuje %s", taking_herb))
    expandAlias("/z_" .. action .. " " .. taking_herb)
    herbs:smart_application_increment_queue(htype)

    if herbs.counts[taking_herb] == nil or herbs.counts[taking_herb] == 0 then
        -- remove from queue
        local new_herb = herbs.smart_application_queue[htype].herbs[herbs.smart_application_queue[htype].index]
        local index_to_remove = table.index_of(herbs.smart_application_queue[htype].herbs, taking_herb)
        table.remove(herbs.smart_application_queue[htype].herbs, index_to_remove)
        herbs.smart_application_queue[htype].index = table.index_of(herbs.smart_application_queue[htype].herbs, new_herb)
    end
end

function herbs:smart_application_increment_queue(htype)
    herbs.smart_application_queue[htype].index = (herbs.smart_application_queue[htype].index + 1) %
        (table.size(herbs.smart_application_queue[htype].herbs) + 1)

    if herbs.smart_application_queue[htype].index == 0 then
        herbs.smart_application_queue[htype].index = 1
    end
end

function herbs:smart_application_htype_queue_pretty_msg(htype)
    local prop_category = herbs.short_category_to_category[htype]
    local herbs_in_htype = herbs.smart_application_queue[htype].herbs
    if herbs.smart_application_queue[htype].index == 0 then
        cecho(string.format(
            " <tomato>%s<CadetBlue> brak ziol w kolejce, aby rozpoczac: /zapl %s\n",
            htype,
            htype))
        return
    end

    cecho(string.format(" <tomato>%s<CadetBlue> ziola w kolejce: ", htype))
    for _, herb_id in pairs(herbs.herbs_categories[prop_category]) do
        if herbs.counts[herb_id] ~= nil and herbs.counts[herb_id] > 0 and herbs.smart_application_action[htype][herb_id] ~= nil then
            local clr = "<grey> "
            if table.index_of(herbs_in_htype, herb_id) == herbs.smart_application_queue[htype].index then
                clr = "<yellow> "
            end
            cecho(clr)

            local herb_s = string.format("%s (%d)", herb_id, herbs.counts[herb_id] or 0)
            if herbs["smart_application_skip_" .. htype][herb_id] ~= nil then
                herb_s = "<s><dim_gray>" .. herb_s .. "</s>"
                local ret = herbs:smart_application_get_clickable_for_disabled(htype, herb_id)
                cechoPopup(herb_s, ret['actions'], ret['hints'], true)
            else
                if table.index_of(herbs_in_htype, herb_id) == herbs.smart_application_queue[htype].index then
                    herb_s = "<yellow>" .. herb_s
                else
                    herb_s = "<slate_blue>" .. herb_s
                end
                local ret = herbs:smart_application_get_clickable_for_enabled(htype, herb_id)
                cechoPopup(herb_s, ret['actions'], ret['hints'], true)
            end
            cecho(",")
        end
    end
    cecho("\n")
end

function herbs:smart_application_add_ignore(htype, herb)
    expandAlias("/cset herbs.smart_application_skip_" .. htype .. "[\"" .. herb .. "\"]=true")

    local current_herb = herbs.smart_application_queue[htype].herbs[herbs.smart_application_queue[htype].index]
    local herb_to_recover = herbs.smart_application_queue[htype].herbs[herbs.smart_application_queue[htype].index]
    -- cecho("herb = " .. herb .. "\n")
    -- cecho("current_herb = " .. current_herb .. "\n")
    -- cecho("herb_to_recover = " .. herb_to_recover .. "\n")
    if current_herb == herb then
        -- increment first, then save the increment herb name, then recover it
        herbs:smart_application_increment_queue(htype)
        herb_to_recover = herbs.smart_application_queue[htype].herbs[herbs.smart_application_queue[htype].index]
        -- cecho("updated herb_to_recover = " .. herb_to_recover .. "\n")
    end

    herbs.smart_application_queue[htype].herbs = {}
    herbs.smart_application_queue[htype].index = 0
    herbs:smart_application_init_htype_queue(htype)
    herbs.smart_application_queue[htype].index = table.index_of(herbs.smart_application_queue[htype].herbs,
        herb_to_recover)
end

function herbs:smart_application_remove_ignore(htype, herb)
    expandAlias("/cdel herbs.smart_application_skip_" .. htype .. "[\"" .. herb .. "\"]")

    local current_herb = herbs.smart_application_queue[htype].herbs[herbs.smart_application_queue[htype].index]
    herbs.smart_application_queue[htype].herbs = {}
    herbs.smart_application_queue[htype].index = 0
    herbs:smart_application_init_htype_queue(htype)
    herbs.smart_application_queue[htype].index = table.index_of(herbs.smart_application_queue[htype].herbs, current_herb) or
        1
end

function herbs:smart_application_get_clickable_for_disabled(htype, herb)
    local action = herbs.smart_application_action[htype][herb]
    local actions = { "", [[expandAlias("/z_]] .. action .. [[ ]] .. herb .. [[")]],
        [[herbs:smart_application_remove_ignore("]] .. htype .. [[","]] .. herb .. [[")]] }
    local hints = { herb, action .. " " .. herb, "dodaj to aplikowanych" }
    return { actions = actions, hints = hints }
end

function herbs:smart_application_get_clickable_for_enabled(htype, herb)
    local action = herbs.smart_application_action[htype][herb]
    local actions = { "", [[expandAlias("/z_]] .. action .. [[ ]] .. herb .. [[")]],
        [[herbs:smart_application_add_ignore("]] .. htype .. [[","]] .. herb .. [[")]] }
    local hints = { herb, action .. " " .. herb, "usun z aplikowanych" }
    return { actions = actions, hints = hints }
end

function herbs:smart_application_init_htype_queue(htype)
    local prop_category = herbs.short_category_to_category[htype]
    for _, herb_id in pairs(herbs.sorted_herb_ids) do
        if table.contains(herbs.herb_to_categories[herb_id], prop_category) and herbs["smart_application_skip_" .. htype][herb_id] == nil then
            table.insert(herbs.smart_application_queue[htype].herbs, herb_id)
        end
    end
    if table.size(herbs.smart_application_queue[htype].herbs) > 0 then
        herbs.smart_application_queue[htype].index = 1
    end
end

function alias_func_skrypty_herbs_smart_apply(htype)
    if not herbs.db or table.size(herbs.db) == 0 then
            herbs:print_build_herbs_db_message()
            return
    end
    herbs:smart_application_execute(htype)
end

function alias_func_skrypty_herbs_smart_apply_reset(htype)
    herbs.smart_application_queue[htype].herbs = {}
    herbs.smart_application_queue[htype].index = 0
    herbs:smart_application_init_htype_queue(htype)
    scripts:print_log("ok")
end

function alias_func_skrypty_herbs_smart_apply_show_status()
    scripts:print_log("aktualna kolejka")
    herbs:smart_application_htype_queue_pretty_msg("kon")
    herbs:smart_application_htype_queue_pretty_msg("man")
    herbs:smart_application_htype_queue_pretty_msg("zme")
end
