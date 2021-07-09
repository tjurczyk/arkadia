function scripts.inv.weapons:get_case(id)
    return scripts.inv.weapons.case[tonumber(id)]
end

function scripts.inv.weapons:get_weapon(id)
    local actions_on = scripts.inv.weapons.weapon_on_actions[id]
    local bag = scripts.inv.weapons.cases[id]
    local bag_dopelniacz = scripts.inv.weapons.cases_dopelniacz[id]

    if not actions_on or not bag_dopelniacz then
        error("weapon with id " .. tostring(id) .. " is not properly configured")
    end

    scripts.inv.weapons:execute_weapon_actions(bag, bag_dopelniacz, actions_on)
end

function scripts.inv.weapons:lower_weapon(id)
    local actions_off = scripts.inv.weapons.weapon_off_actions[id]
    local bag = scripts.inv.weapons.cases[id]
    local bag_dopelniacz = scripts.inv.weapons.cases_dopelniacz[id]

    if not actions_off or not bag_dopelniacz then
        error("weapon with id " .. tostring(id) .. " is not properly configured")
    end

    scripts.inv.weapons:execute_weapon_actions(bag, bag_dopelniacz, actions_off)
end

function scripts.inv.weapons:execute_weapon_actions(bag, bag_dopelniacz, actions)
    local table_actions = string.split(actions, "[;#]")

    for _, action in pairs(table_actions) do
        local bag_macro = string.match(action, "<[^>]+>")
        if bag_macro then
            local proper_bag_macro = string.sub(bag_macro, 2, -2)

            if proper_bag_macro == "pojemnik" then
                local replaced_action = string.gsub(action, bag_macro, bag, 1)
                send(replaced_action, true)
            elseif proper_bag_macro == "dopelniacz_pojemnik" then
                local replaced_action = string.gsub(action, bag_macro, bag_dopelniacz, 1)
                send(replaced_action, true)
            elseif string.match(bag_macro, "_bag_") then
                for _, pre_command in pairs(scripts.inv:get_pre_commands_for_bag(proper_bag_macro)) do
                    send(pre_command, true)
                end
                send(scripts.inv:decorate_command_with_proper_bag_forms(action), true)
                for _, post_command in pairs(scripts.inv:get_post_commands_for_bag(proper_bag_macro)) do
                    send(post_command, true)
                end
            end
        else
            send(action)
        end
    end
end


function scripts.inv.weapons:get_weapons()
    if scripts.inv.weapons.main_weapons_action and table.size(scripts.inv.weapons.main_weapons_action) > 0 then
        for k, v in pairs(scripts.inv.weapons.main_weapons_action) do
            scripts.inv.weapons:get_weapon(v)
        end
    else
        send(scripts.inv.weapons.wield, true)
    end
end

function scripts.inv.weapons:lower_weapons()
    if scripts.inv.weapons.main_weapons_action and table.size(scripts.inv.weapons.main_weapons_action) > 0 then
        for i = #scripts.inv.weapons.main_weapons_action, 1, -1 do
            scripts.inv.weapons:lower_weapon(scripts.inv.weapons.main_weapons_action[i])
        end
    else
        send("opusc wszystkie bronie", true)
    end
end

