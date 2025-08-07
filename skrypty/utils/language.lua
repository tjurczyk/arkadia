function scripts.utils:get_form_based_on_count(count)
    -- returns "biernik" or "dopelniacz" based on the correct form from count.
    -- based on http://www.lpj.pl/index.php?op=35&id=15

    local local_count = tostring(count)

    if local_count == "1" then
        return "biernik"
    end

    if local_count == "12" or local_count == "13" or local_count == "14" then
        return "dopelniacz"
    end

    local last_digit = string.sub(local_count, -1)
    if last_digit == "1" or last_digit == "5" or last_digit == "6" or last_digit == "7" or last_digit == "8" or last_digit == "9" or last_digit == "0" then
        return "dopelniacz"
    end

    return "biernik"
end

function scripts.utils:get_best_fuzzy_match(query, docs, min_ratio)
    -- splits all elements by white space. Checks word match with appropriate min_ratio.
    -- returns a first id in docs that passes the test or -1 if none

    local query_tokens = string.split(query, " ")
    for k, v in pairs(query_tokens) do
        local token_length_scaled = round(#v * min_ratio, 0)
        query_tokens[k] = string.lower(string.sub(v, 0, token_length_scaled))
    end
    for k, v in pairs(docs) do
        local doc_tokens = string.split(v, " ")
        if table.size(doc_tokens) == table.size(query_tokens) then
            local match = true
            for var = 1, table.size(doc_tokens) do
                if not string.starts(string.lower(doc_tokens[var]), query_tokens[var]) then
                    match = false
                    break
                end
            end
            if match then
                return k
            end
        end
    end
    return -1
end

function scripts.utils:get_id_from_name(name)
    if ateam and ateam.objs then
        for k, v in pairs(ateam.objs) do
            if v.desc == name then
                return k
            end
        end
    end
end
