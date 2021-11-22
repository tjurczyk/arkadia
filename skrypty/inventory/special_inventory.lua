scripts.inv.get_magics_to_put_down_exempts = {
    ["plytach twojego starozytnego pancerza"] = "starozytna runiczna zbroje plytowa",
    ["mosiezna duza broszka w ksztalcie liscia debu"] = "mosiezna duza broszke w ksztalcie liscia debu",
    ["zielonym luskowatym plaszczem"] = "zielony luskowaty plaszcz",
    ["szmaragdowozielonym misternym plaszczem"] = "szmaragdowozielony misterny plaszcz",
    ["krasnoludzka starozytna korone"] = false,
    ["kruczoczarny misterny miecz"] = false,
    ["zamkniety ozdobny skorzany plecak"] = false,
    ["otwarty ozdobny skorzany plecak"] = false,
    ["ozdobny skorzany plecak"] = false
}

function scripts.inv:set_all_magic()
    scripts.inv:setup_magics_triggers()
    scripts.inv:setup_magic_keys_triggers()
end

function scripts.inv:setup_magics_triggers()
    local magic_callback = function(current_match)
        if selectString(current_match, 1) > -1 then
            fg(scripts.inv.magics_color)
            resetFormat()
        end
    end

    if scripts.inv.magics_data then
        for magic, properties in pairs(scripts.inv.magics_data.magics) do
            for _, regexp in pairs(properties.regexps) do
                scripts.tokens:register(regexp, magic_callback)
            end
        end
    end
end

function scripts.inv:setup_magic_keys_triggers()
    if scripts.inv["magic_keys_data"]["magic_keys"] then
        for k, v in pairs(scripts.inv["magic_keys_data"]["magic_keys"]) do
            local key_callback = function(current_match)
                if selectString(current_match, 1) > -1 then
                    fg(scripts.inv.magic_keys_color)
                    resetFormat()
                end
            end
            scripts.tokens:register(v, key_callback)
        end
    end
end

function scripts.inv:find_magic(magic)
    for key, properties in pairs(scripts.inv.magics_data.magics) do
        if table.contains(properties.regexps, magic) then
            return key, properties
        end
    end
    return false
end

function scripts.inv:get_magics_to_put_down(container)
    local chosen_container = container or "skrzyni"
    self.magic_items_in_inventory = {
        triggers = {},
        items = {}
    }
    for key, properties  in pairs(scripts.inv.magics_data.magics) do
        for _, item in pairs(properties.regexps) do
            table.insert(self.magic_items_in_inventory.triggers, tempRegexTrigger(self:get_magic_item_pattern(item),
                    function() self.magic_items_in_inventory.items[item] = item end))
        end
    end
    table.insert(self.magic_items_in_inventory.triggers, tempRegexTrigger("Masz przy sobie|Nie masz nic przy sobie", function() coroutine.resume(scripts.inv.magic_put_down_coroutine) end))
    send("i")
    coroutine.yield(scripts.inv.magic_put_down_coroutine)
    for k, trigger in pairs(self.magic_items_in_inventory.triggers) do
        killTrigger(trigger)
    end

    if table.size(self.magic_items_in_inventory.items) > 0 then
        local command = ""
        for k, item in pairs(self.magic_items_in_inventory.items) do
            if self.get_magics_to_put_down_exempts[item] ~= nil then
                item = self.get_magics_to_put_down_exempts[item]
            end
            if item then
                command = command .. "wloz " .. item .. " do ".. chosen_container .. ";"
            end
        end
        if command ~= "" then
            scripts.utils.bind_functional(command, false, true)
        end
    end
    self.magic_items_in_inventory = nil
end

function scripts.inv:get_magic_item_pattern(item)
    local first_letter = string.sub(item, 1, 1)
    local upper_first_letter = string.upper(first_letter)
    local rest_of_string = string.sub(item, 2)

    return "([" .. upper_first_letter .. first_letter .. "]" .. rest_of_string .. ")"
end

function scripts.inv:magic_worn_off(message, type)
    creplaceLine("<tomato>\n\n\t[  MAGIK ZNIKA   ] " .. message .. "\n\n")
    resetFormat()

    raiseEvent("playBeep")
    scripts.ui:info_action_update("ZNI. " .. type)
end

function alias_func_put_magics_down()
    scripts.inv.magic_put_down_coroutine = coroutine.create(function ()
        scripts.inv:get_magics_to_put_down(matches[3])
    end)
    coroutine.resume(scripts.inv.magic_put_down_coroutine)
end

function trigger_func_magic_dissapears(message, type)
    scripts.inv:magic_worn_off(message, type)
end
