function misc:value_to_gold(amount, str)
    selectString(str, 1)
    local money_str = misc:get_valued_string(amount)
    replace("")
    cecho(string.sub(str, 0, -2) .. ", czyli" .. money_str .. ".")
end

function misc:value_stones()
    misc["stones_value"] = 0
    misc["valuing_stones"] = true
    send("ocen kamienie", false)
    tempTimer(0.7, [[ misc:print_stones_value() ]])
end

function misc:add_stone_value(val)
    if misc["valuing_stones"] then
        misc["stones_value"] = misc["stones_value"] + val
    end
end

function misc:print_stones_value()
    local money_str = misc:get_valued_string(misc["stones_value"])
    --cecho (str .. ", czyli" .. money_str .. ".")
    misc["stones_value"] = nil
    scripts:print_log("Kamienie sa warte:" .. money_str)

    misc["valuing_stones"] = nil
end

