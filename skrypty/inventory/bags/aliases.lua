function scripts.inv:wdp_id(bag_id, things_string)
    --[[
    support for wdp.
      --]]

    if not bag_id or not things_string then
        error("bag_id or/and things_string is nil in scripts.inv:wdp_id")
    end

    local things_list = string.split(things_string, ",")
    scripts.inv:put_into_bag(things_list, "other", tonumber(bag_id))
end

function scripts.inv:wzp_id(bag_id, things_string)
    --[[
    support for wzp.
      --]]

    if not bag_id or not things_string then
        error("bag_id or/and things_string is nil in scripts.inv:wzp_id")
    end

    local things_list = string.split(things_string, ",")
    scripts.inv:get_from_bag(things_list, "other", tonumber(bag_id))
end



