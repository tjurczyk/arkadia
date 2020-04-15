function scripts.inv:special_inventory_highlight(text, color)
    selectString(text, 1)
    fg(color)
    resetFormat()
end

function scripts.inv:setup_special_inventory_highlight(item, color)
    if not item then
        error("Wrong input")
    end

    local first_letter = string.sub(item, 1, 1)
    local upper_first_letter = string.upper(first_letter)
    local rest_of_string = string.sub(item, 2)

    local regex = "([" .. upper_first_letter .. first_letter .. "]" .. rest_of_string .. ")"

    local id = tempRegexTrigger(regex, [[ scripts.inv:special_inventory_highlight(matches[2], "]] .. color .. [[") ]])
    return id
end

function scripts.inv:set_all_magic()
    scripts.inv:setup_magics_triggers()
    scripts.inv:setup_magic_keys_triggers()
end

function scripts.inv:setup_magics_triggers()
    for k, v in pairs(scripts.inv.magics_trigger_ids) do
        killTrigger(v)
    end

    scripts.inv.magics_trigger_ids = {}

    if scripts.inv["magics_data"]["magics"] then
        for k, v in pairs(scripts.inv["magics_data"]["magics"]) do
            table.insert(scripts.inv.magics_trigger_ids, scripts.inv:setup_special_inventory_highlight(v, scripts.inv.magics_color))
        end
    end
end

function scripts.inv:setup_magic_keys_triggers()
    for k, v in pairs(scripts.inv.magic_keys_trigger_ids) do
        killTrigger(v)
    end

    scripts.inv.magic_keys_trigger_ids = {}

    if scripts.inv["magic_keys_data"]["magic_keys"] then
        for k, v in pairs(scripts.inv["magic_keys_data"]["magic_keys"]) do
            table.insert(scripts.inv.magic_keys_trigger_ids, scripts.inv:setup_special_inventory_highlight(v, scripts.inv.magic_keys_color))
        end
    end
end


