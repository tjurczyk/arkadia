function scripts.inv:get_pre_commands_for_bag(bag_id)
    --[[
      Returns the pre commands for a specific bag if available or nil otherwise.
      --]]
    return scripts.inv:_get_pre_post_commands("pre", scripts.inv:get_bag_id_from_bag_name(bag_id))
end

function scripts.inv:get_post_commands_for_bag(bag_id)
    --[[
      Returns the post commands for a specific bag if available or nil otherwise.
      --]]
    return scripts.inv:_get_pre_post_commands("post", scripts.inv:get_bag_id_from_bag_name(bag_id))
end

function scripts.inv:_get_pre_post_commands(prefix, bag_id)
    --[[
      Returns the prefix- commands for a specific bag if available or nil otherwise.
    if bag_id == <type>_bag_<id> then it gets the commands directly.
    if bag_id contains prefix (desc_, dopelniacz_ or _biernik_), it removed prefix first.
      --]]
    if not prefix or not bag_id then
        error("prefix or/and bag_id empty in scripts.inv:_get_pre_post_commands")
    end

    local action_bag_id = nil
    if prefix == "pre" then
        action_id_bag = "pre_"
    elseif prefix == "post" then
        action_id_bag = "post_"
    else
        error("wrong prefix in scripts.inv:_get_pre_post_commands")
    end

    action_id_bag = action_id_bag .. bag_id

    if scripts.inv[action_id_bag] then
        return string.split(scripts.inv:decorate_command_with_proper_bag_forms(scripts.inv[action_id_bag]), "[#;]")
    end

    return {}
end

