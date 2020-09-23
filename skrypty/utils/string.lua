function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

function trim_string(str)
    return str:match("^%s*(.-)%s*$")
end

function scripts.utils:separate_bind(bind_str)
    if not bind_str then
        error("Wrong input")
    end

    local binds_return = {}
    local binds = string.split(bind_str, "#")

    for k, v in pairs(binds) do
        local bind = string.split(v, "*")
        local delay = nil
        local di = { ["bind"] = bind[1] }

        if table.size(bind) > 2 then
            error("Wrong input")
        elseif table.size(bind) == 2 then
            di["delay"] = tonumber(bind[2])
        end

        table.insert(binds_return, di)
    end

    return binds_return
end

function string:split_people(str)
    if not str or str == "" then
        return {}
    end

    local sep = string.split(str, ",")
    local sep1 = string.split(sep[#sep], " i ")
    local sep_trimmed = {}

    for k, v in pairs(sep) do
        table.insert(sep_trimmed, v:match("^%s*(.-)%s*$"))
    end
    sep = sep_trimmed
    local sep_trimmed = {}
    for k, v in pairs(sep1) do
        table.insert(sep_trimmed, v:match("^%s*(.-)%s*$"))
    end
    sep1 = sep_trimmed

    if #sep == 1 then
        -- this is just 2
        return sep1
    else
        table.remove(sep, #sep)
        table.insert(sep, sep1[1])
        table.insert(sep, sep1[2])
        return sep
    end

    display(sep)
    display(sep1)
end

function scripts.utils:extract_string_list(list_str)
    local items = {}

    local split_by_i = string.split(list_str, " i ")

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

    return scripts.utils:_extract_list_items(items)
end

function scripts.utils:_extract_list_items(list_arr)
    if not list_arr then
        error("Wrong input")
    end

    extracted = {}

    for k, v in pairs(list_arr) do
        local split_by_words = string.split(v, " ")
        local item = {}

        --echo ("Working on: " .. table.concat(split_by_words, " ") .. "\n")

        local int_number = string.match(split_by_words[1], "[0-9]+")
        if int_number then
            -- this is when "25 zoltych jasnych kwiatow"
            item["name"] = table.concat(scripts:get_table_without_first_item(split_by_words), " ")
            item["amount"] = int_number
        else
            local liczebnik_number = scripts.string_to_liczebnik[split_by_words[1]]
            if liczebnik_number then
                -- this is when "siedemnascie zoltych jasnych kwiatow"
                item["name"] = table.concat(scripts:get_table_without_first_item(split_by_words), " ")
                item["amount"] = liczebnik_number
            else
                if split_by_words[1] == "wiele" then
                    -- this is when "wiele zoltych jasnych kwiatow"
                    item["name"] = table.concat(scripts:get_table_without_first_item(split_by_words), " ")
                    item["amount"] = "wie"
                else
                    -- this is when "zolty jasny kwiat"
                    item["name"] = table.concat(split_by_words, " ")
                    item["amount"] = 1
                end
            end
        end
        extracted[item.name] = item
    end

    return extracted
end

function scripts.utils:print_string_list(list_arr)
    if not list_arr then
        error("Wrong input")
    end

    cecho("\n")
    cecho("------------------------------------- <green>Pojemnik<grey> -----------------------------------")
    cecho("\n  <light_slate_blue>ile   <grey>|        <light_slate_blue>nazwa")
    cecho("\n----------------------------------------------------------------------------------")

    local ret_str = ""

    for k, v in pairs(list_arr) do
        local amount_str = nil
        if v["amount"] == -1 then
            amount_str = "wie"
        else
            local amount_tmp = "    " .. tostring(v["amount"])
            amount_str = string.sub(amount_tmp, string.len(amount_tmp) - 4, string.len(amount_tmp))
        end
        if table.contains(scripts.inv.magics_data.magics, string.lower(v["name"])) then
            ret_str = ret_str .. "\n<grey>  " .. amount_str .. " | <" .. scripts.inv.magics_color .. ">" .. v["name"]
        elseif table.contains(scripts.inv.magic_keys_data.magic_keys, string.lower(v["name"])) then
            ret_str = ret_str .. "\n<grey>  " .. amount_str .. " | <" .. scripts.inv.magic_keys_color .. ">" .. v["name"]
        else
            ret_str = ret_str .. "\n<grey>  " .. amount_str .. " | " .. v["name"]
        end
    end

    cecho(ret_str)
    --cecho(herbs:get_printable_bag(herbs_arr))
    --local h_str = herbs:get_printable_bag(herbs_arr)
    --cecho(herbs:get_printable_bag(herbs_arr))
    --cecho ("\n--------------------------------------------------------------------------------")
end

function scripts.utils:serialize_dir_bind(t)
    if not t or type(t) ~= "table" then
        error("Wrong input")
    end

    local s = ""
    local idx = 1
    for k, v in pairs(t) do
        s = s .. k .. "=" .. v
        if idx ~= table.size(t) then
            s = s .. "&"
        end
        idx = idx + 1
    end

    return s
end

function scripts.utils:deserialize_dir_bind(s)
    if not s or type(s) ~= "string" then
        error("Wrong input")
    end

    local items = string.split(s, "&")
    local ret_dict = {}
    for k, v in pairs(items) do
        local tmp = string.split(v, "=")
        ret_dict[tmp[1]] = tmp[2]
    end

    return ret_dict
end

function scripts.utils.real_len(str)
    str = str:gsub("<[^<]*>", "")
    return string.len(str)
end

function scripts.utils.str_pad(str, length, align)
    local total_pad = length - scripts.utils.real_len(str:gsub("\<[%a_]+\>", ""))
    local prepad = align == "center" and math.floor(total_pad / 2) or (align == "right" and total_pad or 0)
    local postpad = total_pad - prepad
    return string.rep(" ", prepad) .. str .. string.rep(" ", postpad)
end