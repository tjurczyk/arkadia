function scripts.inv:_get_desc_for_bag_id(id_bag_name)
    --[[
      Returns the description of the bag if available otherwise nil.
      --]]

    if not id_bag_name then
        error("wrong input in scripts.inv:_get_desc_for_bag_id")
    end

    local desc_bag_id = "desc_" .. id_bag_name
    if desc_bag_id and scripts.inv[desc_bag_id] then
        return scripts.inv[desc_bag_id]
    end

    return ""
end

function scripts.inv:get_bag_id_from_bag_name(any_bag_name)
    --[[
      Returns the proper bag_id for any bag name.
    - for other_bag_1 will return other_bag_1
    - for *_other_bag_1 (dopelniacz_, biernik_, etc) will return other_bag_1
      --]]
    local bag_components = string.split(any_bag_name, "_")
    if table.size(bag_components) < 3 or table.size(bag_components) > 4 then
        error("wrong any bag name in scripts.inv:get_bag_id_from_bag_name")
    end

    if table.size(bag_components) == 3 then
        return any_bag_name
    elseif table.size(bag_components) == 4 then
        return table.concat({ unpack(bag_components, 2, 5) }, "_")
    else
        error("wrong any bag name in scripts.inv:get_bag_id_from_bag_name")
    end
end

