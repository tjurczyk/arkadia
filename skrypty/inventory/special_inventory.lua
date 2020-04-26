function scripts.inv:special_inventory_highlight(text, color)
    selectString(text, 1)
    fg(color)
    resetFormat()
end

function scripts.inv:setup_special_inventory_highlight(item, color)
    if not item then
        error("Wrong input")
    end

    local regex = self:get_magic_item_pattern(item)

    return tempRegexTrigger(regex, [[ scripts.inv:special_inventory_highlight(matches[2], "]] .. color .. [[") ]])
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

function scripts.inv:get_magics_to_put_down()
    send("i")
    self.magic_items_in_inventory = {
        triggers = {},
        items = {}
    }

    for k, item  in pairs(scripts.inv["magics_data"]["magics"]) do
         table.insert(self.magic_items_in_inventory.triggers, tempRegexTrigger(self:get_magic_item_pattern(item),
                 function() table.insert(self.magic_items_in_inventory.items, item) end))
    end
    table.insert(self.magic_items_in_inventory.triggers, tempRegexTrigger("Masz przy sobie|Nie masz nic przy sobie", function() coroutine.resume(scripts.inv.magic_put_down_coroutine) end))
    coroutine.yield(scripts.inv.magic_put_down_coroutine)
    for k, trigger in pairs(self.magic_items_in_inventory.triggers) do
        killTrigger(trigger)
    end

    if table.size(self.magic_items_in_inventory.items) > 0 then
        local command = ""
        for k, item in pairs(self.magic_items_in_inventory.items) do
            command = command .. "wloz " .. item .. " do skrzyni;"
        end
        scripts.utils.bind_functional(command, false, false)
    end
    self.magic_items_in_inventory = nil
end

function scripts.inv:get_magic_item_pattern(item)
    local first_letter = string.sub(item, 1, 1)
    local upper_first_letter = string.upper(first_letter)
    local rest_of_string = string.sub(item, 2)

    return "([" .. upper_first_letter .. first_letter .. "]" .. rest_of_string .. ")"
end

function alias_func_put_magics_down()
    scripts.inv.magic_put_down_coroutine = coroutine.create(function ()
        scripts.inv:get_magics_to_put_down()
    end)
    coroutine.resume(scripts.inv.magic_put_down_coroutine)
end
