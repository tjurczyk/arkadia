function herbs:init_herbs()
    if herbs["use_herb_triggers"] then
        herbs:create_triggers()
    end
    herbs:v2_init_data()
    herbs:init_smart_application()
    herbs.window:create()
end

function herbs:check_single_bag(herbs_str)
    local items = {}

    local split_by_i = string.split(herbs_str, " i ")

    if table.size(split_by_i) == 1 then
        -- this is single herb
        table.insert(items, split_by_i[1])
    elseif table.size(split_by_i) == 2 then
        -- more than one type in the bag
        table.insert(items, split_by_i[2])

        -- see if more than 2
        local split_by_comma = string.split(split_by_i[1], ", ")

        for k, v in pairs(split_by_comma) do
            -- add each herb from splited by ','
            table.insert(items, v)
        end
    end

    -- extract them and return
    return herbs:extract_herbs(items)
end

function herbs:extract_herbs(herbs_arr)
    if not herbs_arr then
        error("Wrong input")
    end

    extracted = {}

    for k, v in pairs(herbs_arr) do
        local split_by_words = string.split(v, " ")
        local item = {}

        --echo ("Working on: " .. table.concat(split_by_words, " ") .. "\n")

        local int_number = string.match(split_by_words[1], "[0-9]+")
        if int_number then
            -- this is when "25 zoltych jasnych kwiatow"
            item["name"] = herbs.herbs_long_to_short
                [table.concat(scripts:get_table_without_first_item(split_by_words), " ")]
            item["amount"] = tonumber(int_number)
        else
            local liczebnik_number = scripts.string_to_liczebnik[split_by_words[1]]
            if liczebnik_number then
                -- this is when "siedemnascie zoltych jasnych kwiatow"
                item["name"] = herbs.herbs_long_to_short
                    [table.concat(scripts:get_table_without_first_item(split_by_words), " ")]
                item["amount"] = liczebnik_number
            else
                if split_by_words[1] == "wiele" then
                    -- this is when "wiele zoltych jasnych kwiatow"
                    item["name"] = herbs.herbs_long_to_short
                        [table.concat(scripts:get_table_without_first_item(split_by_words), " ")]
                    item["amount"] = herbs["many_to_int"]
                else
                    -- this is when "zolty jasny kwiat"
                    item["name"] = herbs.herbs_long_to_short[table.concat(split_by_words, " ")]
                    item["amount"] = 1
                end
            end
        end
        if item["name"] == nil then
            scripts:print_log("nierozpoznane ziolo: " .. tostring(v), true)
            error("nierozpoznane ziolo: " .. tostring(v))
        end
        extracted[item.name] = item
    end

    return extracted
end

function herbs:search_herbs(search_phrase)
    cecho("\n <tomato>Znalazlem nastepujace ziola: \n\n")
    for herb_name, dict in pairs(herbs.herbs_details) do
        if string.match(dict["desc"], ".*" .. search_phrase .. ".*") or string.match(dict["details"], ".*" .. search_phrase .. ".*") or string.match(herb_name, ".*" .. search_phrase .. ".*") then
            if herbs.index and herbs.index[herb_name] then
                cecho("<grey> (<green>++<grey>) ")
            else
                cecho("<grey> (--<grey>) ")
            end
            cecho(herbs:get_printable_herb_dict(herb_name, dict) .. "\n")
        end
    end
end

function herbs:get_printable_herb_dict(herb_name, herb_dict)
    return "<light_slate_blue>" ..
        herb_dict["desc"] .. "<grey> (<yellow>" .. herb_name .. "<grey>) -> " .. herb_dict["details"]
end

function herbs:create_triggers()
    for herb_long, herb_name in pairs(herbs.herbs_long_to_short) do
        scripts.tokens:register(herb_long, function(current_match) herbs:process_trigger(current_match, herb_name) end,
            "herbs " .. herb_name)
    end
end

function herbs:process_trigger(herb_match, herb_name)
    if line:starts("|") then
        return
    end
    if selectString(herb_match, 1) > -1 then
        replace(herb_match .. " (" .. herb_name .. ")")
    end
    if selectString(herb_name, 1) > -1 then
        fg("blanched_almond")
    end
    local ln = getLineNumber()
    setLink(function()
        moveCursor(0, ln)
        if selectString(herb_name, 1) > -1 then
            creplace("<blanched_almond>" ..
                herb_name .. "<reset> " .. herbs.herbs_details[herb_name]["details"] .. "<reset>")
        end
        moveCursorEnd()
    end, herbs.herbs_details[herb_name]["details"])
    resetFormat()
end

function herbs:print_db(ver)
    if not herbs.db or table.size(herbs.db) == 0 then
        return
    end

    cecho("\n")
    cecho("--------------------------- <green>Ziola w twojej bazie<grey> -------------------------------")
    cecho(
        "\n  <light_slate_blue>ile <grey>|        <light_slate_blue>nazwa <grey>            | <light_slate_blue>             dzialanie <grey>                      ")
    cecho("\n--------------------------------------------------------------------------------")

    for k, v in pairs(herbs.index) do
        if table.size(v) > 0 then
            local amount = 0
            for i, j in pairs(v) do
                amount = amount + herbs.db[i][k]["amount"]
            end
            local amount_tmp = "    " .. tostring(amount)
            local name_str = string.sub(k .. "                      ", 0, 24)
            local usage_str = string.sub(
                herbs.herbs_details[k]["details"] .. "                                                                 ",
                0,
                64)
            cecho("\n<grey>  " .. string.sub(amount_tmp, #amount_tmp - 2, #amount_tmp) .. " | ")
            if ver and ver == "2" then
                cecho(name_str)
            else
                cecho(name_str)
            end

            cecho(" | " .. usage_str)
        end
    end
    cecho("\n--------------------------------------------------------------------------------\n")
end

function herbs:print_single(herbs_arr)
    if not herbs_arr then
        error("Wrong input")
    end

    cecho("\n")
    cecho("--------------------------- <green>Ziola w tym woreczku<grey> -------------------------------")
    cecho(
        "\n  <light_slate_blue>ile <grey>|        <light_slate_blue>nazwa <grey>            | <light_slate_blue>             dzialanie <grey>                      ")
    cecho("\n--------------------------------------------------------------------------------")

    --cecho(herbs:get_printable_bag(herbs_arr))
    local h_str = herbs:get_printable_bag(herbs_arr)
    cecho(herbs:get_printable_bag(herbs_arr))
    cecho("\n--------------------------------------------------------------------------------")
end

function herbs:get_printable_bag(herbs_arr)
    local ret_str = ""

    for k, v in pairs(herbs_arr) do
        local amount_str = nil
        if v["amount"] == -1 then
            amount_str = "wie"
        else
            local amount_tmp = "   " .. tostring(v["amount"])
            amount_str = string.sub(amount_tmp, string.len(amount_tmp) - 2, string.len(amount_tmp))
        end

        local name_str = string.sub(v["name"] .. "                      ", 0, 24)
        local usage_str = string.sub(
            herbs.herbs_details[v["name"]]["details"] ..
            "                                                                 ",
            0, 64)

        ret_str = ret_str .. "\n<grey>  " .. amount_str .. " | " .. name_str .. " | " .. usage_str
    end

    return ret_str
end

tempTimer(0.652, function() herbs:init_herbs() end)
