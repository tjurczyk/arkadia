function ateam:may_setup_paralyzed_name(name_in_declension)
    local id_of_people_on_location_found = scripts.utils:get_best_fuzzy_match(name_in_declension, ateam.people_on_location, 0.6)
    if id_of_people_on_location_found ~= -1 then
        local desc = ateam.people_on_location[id_of_people_on_location_found]
        ateam:setup_paralyzed(desc)
        local id = scripts.utils:get_id_from_name(desc)
        if id then
            raiseEvent("startParalyzed", id)
        end
    end
end

function ateam:may_end_paralyzed_name(name_in_declension)
    local id_of_people_on_location_found = scripts.utils:get_best_fuzzy_match(name_in_declension, ateam.people_on_location, 0.6)
    if id_of_people_on_location_found ~= -1 then
        local desc = ateam.people_on_location[id_of_people_on_location_found]
        ateam:end_paralyzed(desc)
        local id = scripts.utils:get_id_from_name(desc)
        if id then
            raiseEvent("endParalyzed", id)
        end
    end
end

function ateam:setup_paralyzed(name)
    -- sets up paralyzed event for "name"
    ateam.paralyzed_names[name] = true
    ateam.paralyzed_name_to_safety_timer[name] = tempTimer(15, [[ ateam:end_paralyzed("]] .. name .. [[")]])
    ateam:print_status()
end

function ateam:end_paralyzed(name)
    ateam.paralyzed_names[name] = nil
    if ateam.paralyzed_name_to_safety_timer[name] then
        killTimer(ateam.paralyzed_name_to_safety_timer[name])
    end
    ateam.paralyzed_name_to_safety_timer[name] = nil
    ateam:print_status()
end

function ateam:may_setup_broken_defense(name_in_declension)
    local id_of_people_on_location_found = scripts.utils:get_best_fuzzy_match(name_in_declension, ateam.people_on_location, 0.6)
    if id_of_people_on_location_found ~= -1 then
        ateam:setup_broken_defense(ateam.people_on_location[id_of_people_on_location_found])
    end
end

function ateam:setup_broken_defense(name)
    ateam.broken_defense_names[name] = true
    if ateam.broken_defense_name_to_safety_timer[name] ~= nil then
        killTimer(ateam.broken_defense_name_to_safety_timer[name])
    end
    ateam.broken_defense_name_to_safety_timer[name] = tempTimer(3, [[ ateam:end_broken_defense("]] .. name .. [[")]])
    ateam:print_status()
end

function ateam:end_broken_defense(name)
    ateam.broken_defense_names[name] = nil
    ateam.broken_defense_name_to_safety_timer[name] = nil
    ateam:print_status()
end

