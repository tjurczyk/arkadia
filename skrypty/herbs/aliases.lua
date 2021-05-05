function herbs:get_herbs(name, amount)
    if not herbs.herbs_details[name] then
        scripts:print_log("Nie znam takiego ziola")
    end

    local to_get = amount

    if not herbs.index[name] or table.size(herbs.index[name]) == 0 then
        scripts:print_log("Nie ma tego ziola w woreczkach")
        return
    end

    for k, v in pairs(herbs.index[name]) do
        local herbs_taken = herbs:get_herb_from_bag(name, to_get, k)
        if herbs_taken < to_get then
            to_get = to_get - herbs_taken
            -- not taken enough
        else
            to_get = 0
            break
        end
    end

    if to_get > 0 then
        scripts:print_log("Wzialem tylko " .. tostring(amount - to_get) .. " sztuk/i, bo tyle zostalo")
    end
end

function herbs:get_herb_from_bag(name, amount, bag_id)
    local ret_val = nil
    if tonumber(herbs.db[bag_id][name]["amount"]) <= amount then
        ret_val = herbs.db[bag_id][name]["amount"]
        self:send_get_commands(bag_id, herbs.db[bag_id][name]["amount"], name)
        herbs.db[bag_id][name] = nil
        herbs.index[name][bag_id] = nil
    else
        ret_val = amount
        herbs.db[bag_id][name]["amount"] = herbs.db[bag_id][name]["amount"] - amount
        self:send_get_commands(bag_id, amount, name)
    end
    herbs.window:print()
    return ret_val
end

function herbs:send_get_commands(bag_id, amount, herb_id)
    send("otworz " .. scripts.id_to_string[bag_id] .. " woreczek")
    send(string.format("wez %d %s z otwartego woreczka", amount, amount > 1 and herbs.data.herb_id_to_odmiana[herb_id].mnoga_biernik or herbs.data.herb_id_to_odmiana[herb_id].biernik))
    send("zamknij otwarte woreczki")
end


function herbs:pack_herb_with_herb(bag_number, herb)
    if not herbs["herbs_details"][herb] then
        scripts:print_log("Nie znam takiego ziola")
        return
    end

    local bag_number_string = scripts.id_to_string[bag_number]

    if not herbs.index[herb] or table.size(herbs.index[herb]) == 0 then
        scripts:print_log("Nie ma tego ziola w woreczkach")
        return
    end

    local to_get = herbs["full_bag_amount"]

    for k, v in pairs(herbs.index[herb]) do
        local herbs_taken = herbs:get_herb_from_bag(herb, to_get, k)
        if herbs_taken < to_get then
            -- not taken enough
            to_get = to_get - herbs_taken
        else
            to_get = 0
            break
        end
    end

    -- pack to the bag
    sendAll("otworz " .. bag_number_string .. " woreczek", "wloz ziola do niego", "zamknij woreczki")

    if to_get == 0 then
        scripts:print_log("Zapakowane")
    else
        scripts:print_log("Zapakowalem tylko " .. tostring(herbs["full_bag_amount"] - to_get) .. " ziol")
    end

    herbs.window:print()
end

