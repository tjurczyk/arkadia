function misc:wear_collective_start()
    enableTrigger("ubranie-zbiorcze")
    misc["wear_collected"] = {}
    tempTimer(0.3, function() send("ocen ubrania", false) end)
    tempTimer(1.3, function() misc:wear_show_results() end)
    tempTimer(2, function() misc:wear_collective_stop() end)
end

function misc:wear_process_item(item, state)
    local di = {}
    di["name"] = item
    di["state"] = state
    table.insert(misc["wear_collected"], di)
end

function misc:wear_show_results()
    local max_length = nil
    for k, v in pairs(misc["wear_collected"]) do
        if not max_length or max_length < string.len(v["name"]) then
            max_length = string.len(v["name"])
        end
    end
    local concat_str = ".................................................."

    cecho("<orange> Ubrania i ich stany\n\n")

    for k, v in pairs(misc["wear_collected"]) do
        local name = string.sub(v["name"] .. " " .. concat_str .. " ", 1, max_length) .. " -- "
        local state = "<" .. misc["wear_used_color"][v["state"]] .. ">" ..
                misc["wear_used_desc"][v["state"]] .. " " .. v["state"] .. "\n"

        cecho(" " .. name .. state)
    end
end

function misc:wear_collective_stop()
    disableTrigger("ubranie-zbiorcze")
end

