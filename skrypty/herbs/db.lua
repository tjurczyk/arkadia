function herbs:building_counted(counted)
    herbs.bags_amount = nil
    herbs.current_bag_looking = 1
    coroutine.resume(herbs["build_db_coroutine_id"])
end

function herbs:add_to_db(herbs_arr, bag_id)
    if not herbs_arr then
        error("Wrong input")
    end

    herbs.db[bag_id] = {}

    for k, v in pairs(herbs_arr) do
        if not herbs.index[v.name] then
            local tmp_db = {}
            tmp_db[bag_id] = true
            herbs.index[v.name] = tmp_db
        else
            herbs.index[v.name][bag_id] = true
        end
        herbs.db[bag_id][v.name] = v

        if not herbs.counts[v.name] then
            herbs.counts[v.name] = tonumber(v.amount)
        else
            herbs.counts[v.name] = herbs.counts[v.name] + v.amount
        end
    end
end

function herbs:herbs_building_done()
    herbs.current_bag_looking = nil
    herbs.sorted_herb_ids = get_table_sorted_keys(herbs.counts)
    herbs.per_bag_herb_counts = {}
    for k = 1, herbs.bags_amount do
        herbs.per_bag_herb_counts[k] = 0
        if herbs.db[k] then
            for herb_id, herb_dict in pairs(herbs.db[k]) do
                herbs.per_bag_herb_counts[k] = herbs.per_bag_herb_counts[k] + herb_dict["amount"]
            end
        end
    end
    herbs:do_post_actions()
    self.window:print()
end

