function trigger_func_skrypty_misc_money_Oceniasz_ze()
    misc:value_to_gold(tonumber(matches[4]), matches[3])
    misc:add_stone_value(tonumber(matches[4]))
end

function trigger_func_skrypty_misc_money_Oceniasz_ze_1()
    misc:value_to_gold(tonumber(matches[3]), matches[2])
    misc:add_stone_value(tonumber(matches[3]))
end

