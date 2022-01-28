function scripts.inv:get_bag_in_dopelniacz(bag_id)
    --[[
      Returns the bag form in dopelniacz for bag_id.
      --]]

    return scripts.inv:_get_bag_in_form("dopelniacz", bag_id)
end

function scripts.inv:get_bag_in_biernik(bag_id)
    --[[
        Returns the bag form in biernik for bag_id.
      --]]
    return scripts.inv:_get_bag_in_form("biernik", bag_id)
end

function scripts.inv:_get_bag_in_form(form, bag_id)
    --[[
      Returns the bag form in the proper for for bag_type and the count.
      If bag_count is nil, it will apply 1

      Args:
      - form (str): biernik, dopelniacz, etc.
      - bag_id (str): id of the bag ("money_bag_1", etc)
      - bag_name (str): name of the bag ("plecak", "wor", etc)

      Returns:
        Fully formed bag with the extra form description if available.
      --]]

    local this_bag_name = scripts.inv[bag_id]

    if not this_bag_name then
        scripts:print_log("Brak zdefiniowanego pojemnika " .. bag_id)
        error("this_bag_name is nil in _get_bag_in_form")
    end

    local this_bag_name_in_form = scripts.inv["bag_in_" .. form][this_bag_name]

    local prefix_this_bag_name_in_form = scripts.inv["bag_pronouns"][this_bag_name][form] .. (scripts.inv[form .. "_" .. bag_id] and (" " .. scripts.inv[form .. "_" .. bag_id]) or "")
    if not prefix_this_bag_name_in_form or prefix_this_bag_name_in_form:ends(" ") then
        prefix_this_bag_name_in_form = prefix_this_bag_name_in_form .. ""
    else
        prefix_this_bag_name_in_form = prefix_this_bag_name_in_form .. " "
    end

    return prefix_this_bag_name_in_form .. this_bag_name_in_form
end

