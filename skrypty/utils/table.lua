function table_has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function table_concat(t1, t2)
    for i = 1, #t2 do
        t1[#t1 + 1] = t2[i]
    end
    return t1
end

function get_table_sorted_keys(t)
    --returns a table of sorted keys in descending order.

    local tkeys = {}
    -- populate the table that holds the keys
    for k in pairs(t) do table.insert(tkeys, k) end
    table.sort(tkeys)
    return tkeys
end

function get_table_n_smallest_elements(t, n)
    -- finds n smallest elements and returns in the form of table
    -- where each element is {key=..., value=...}

    local already_found_key = {}
    local results_table = {}

    for i = 1, n do
        if table.size(already_found_key) == table.size(t) then
            break
        end

        local current_min = nil
        local current_min_k = nil
        for k, v in pairs(t) do
            if not already_found_key[k] then
                if not current_min or v < current_min then
                    current_min = v
                    current_min_k = k
                end
            end
        end

        already_found_key[current_min_k] = true
        table.insert(results_table, { key = current_min_k, value = current_min })
    end

    return results_table
end 

