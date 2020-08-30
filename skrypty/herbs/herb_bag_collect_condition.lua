function trigger_func_skrypty_herbs_herb_bag_collect_condition_count_herb_bags()
    local bag_condition_with_color = "<" .. misc["item_used_color"][matches[2]] .. "> " .. misc.item_used_desc[matches[2]]
    herbs.herb_bag_collect_condition_data.bag_id_to_condition[herbs.herb_bag_collect_condition_data["current_bag_id"]] = bag_condition_with_color
    coroutine.resume(herbs.herb_bag_collect_condition_data["coroutine_id"])
end

function trigger_func_skrypty_herbs_herb_bag_collect_condition_no_more_herb_bags()
    herbs.herb_bag_collect_condition_data["coroutine_id"] = nil
    if not herbs.bags_amount then
        herbs.bags_amount = herbs.herb_bag_collect_condition_data["current_bag_id"] - 1
    end
    herbs:print_herb_bag_conditions()
end

