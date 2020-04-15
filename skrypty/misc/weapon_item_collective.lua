function misc:weapon_item_collective_start()
    enableTrigger("bronie-zbroje-zbiorcze")
    misc["weapon_item_collected"] = {}
    tempTimer(0.2, function() sendAll("ocen wszystkie bronie", "ocen wszystkie zbroje", false) end)
    tempTimer(1.8, function() misc:weapon_item_show_results() end)
    tempTimer(3, function() misc:weapon_item_collective_stop() end)
end

function misc:weapon_item_process_item(item, state)
    local di = {}
    di["name"] = item
    di["state"] = state
    table.insert(misc["weapon_item_collected"], di)
end

function misc:weapon_item_show_results()
    local max_length = nil
    for k, v in pairs(misc["weapon_item_collected"]) do
        if not max_length or max_length < string.len(v["name"]) then
            max_length = string.len(v["name"])
        end
    end
    local concat_str = ".................................................."

    cecho("<orange> Bronie, zbroje i ich stany\n\n")

    for k, v in pairs(misc["weapon_item_collected"]) do
        local name = string.sub(v["name"] .. " " .. concat_str .. " ", 1, max_length) .. " -- "
        local state = nil

        if misc["item_damaged_desc"][v["state"]] then
            state = "<" .. misc["item_damaged_color"][v["state"]] .. ">" ..
                    misc["item_damaged_desc"][v["state"]] .. " " .. v["state"] .. "\n"
        else
            state = "<" .. misc["weapon_damaged_color"][v["state"]] .. ">" ..
                    misc["weapon_damaged_desc"][v["state"]] .. " " .. v["state"] .. "\n"
        end

        cecho(" " .. name .. state)
    end
end

function misc:weapon_item_collective_stop()
    disableTrigger("bronie-zbroje-zbiorcze")
end

