scripts.inv.equipment.evaluation_extractor = scripts.inv.equipment.evaluation_extractor or {}

local extraction_triggers = {
    ["(.*) przed obrazeniami (klutymi|cietymi|obuchowymi), (.*) przed (klutymi|cietymi|obuchowymi) i (.*) przed (klutymi|cietymi|obuchowymi)."] = function(equipment, matches)
        scripts.inv.equipment.evaluation_extractor:trzy_rozne(equipment, matches)
    end,
    ["(.*) przed obrazeniami (klutymi|cietymi|obuchowymi), (klutymi|cietymi|obuchowymi) i (klutymi|cietymi|obuchowymi)."] = function(equipment, matches)
        scripts.inv.equipment.evaluation_extractor:trzy_na_raz(equipment, matches)
    end,
    ["(.*) przed obrazeniami (cietymi|klutymi|obuchowymi) i (.*) oraz (.*) przed (klutymi|cietymi|obuchowymi)."] = function(equipment, matches)
        scripts.inv.equipment.evaluation_extractor:dwa_i_jeden(equipment, matches)
    end,
    ["(.*)Ponadto jest (.*) w parowaniu ciosow."] = function(equipment, matches)
        scripts.inv.equipment.evaluation_extractor:tarcza(equipment, matches)
    end
}

function scripts.inv.equipment.evaluation_extractor:extract_weapon()
    deleteLine()
    moveCursor(0, getLineNumber() - 1)
    deleteLine()
    moveCursor(0, getLineNumber() - 1)
    deleteLine()
    local equipment = {
        ["chwytanie"] = multimatches[1][3],
        ["obrazenia"] = multimatches[2][3],
        ["typSprzetu"] = multimatches[3][2],
        ["wywazenie"] = multimatches[3][5],
        ["parowanie"] = multimatches[3][7],
    }
    scripts.inv.equipment:replace(equipment)
end

function scripts.inv.equipment.evaluation_extractor:extract_armor()
    deleteLine()
    local equipment = {
        ["typSprzetu"] = matches[3] ~= "" and matches[3] or "tarcza"
    }
    for trigger, callback in pairs(extraction_triggers) do
        local sub_matches = { rex.find(matches[7], trigger) }
        if not table.is_empty(sub_matches) then
            table.remove(sub_matches, 1)
            callback(equipment, sub_matches)
        end
    end
    scripts.inv.equipment:replace(equipment)
end

function scripts.inv.equipment.evaluation_extractor:trzy_rozne(equipment, matches)
    if matches[3] == "klutymi" then
        equipment.klute = matches[2]
    elseif matches[3] == "cietymi" then
        equipment.ciete = matches[2]
    elseif matches[3] == "obuchowymi" then
        equipment.obuchowe = matches[2]
    end
    if matches[5] == "klutymi" then
        equipment.klute = matches[4]
    elseif matches[5] == "cietymi" then
        equipment.ciete = matches[4]
    elseif matches[5] == "obuchowymi" then
        equipment.obuchowe = matches[4]
    end
    if matches[7] == "klutymi" then
        equipment.klute = matches[6]
    elseif matches[7] == "cietymi" then
        equipment.ciete = matches[6]
    elseif matches[7] == "obuchowymi" then
        equipment.obuchowe = matches[6]
    end
end

function scripts.inv.equipment.evaluation_extractor:trzy_na_raz(equipment, matches)
    equipment.klute = matches[2]
    equipment.ciete = matches[2]
    equipment.obuchowe = matches[2]
end

function scripts.inv.equipment.evaluation_extractor:dwa_i_jeden(equipment, matches)
    if matches[3] == "klutymi" then
        equipment.klute = matches[2]
    elseif matches[3] == "cietymi" then
        equipment.ciete = matches[2]
    elseif matches[3] == "obuchowymi" then
        equipment.obuchowe = matches[2]
    end
    if matches[4] == "klutymi" then
        equipment.klute = matches[2]
    elseif matches[4] == "cietymi" then
        equipment.ciete = matches[2]
    elseif matches[4] == "obuchowymi" then
        equipment.obuchowe = matches[2]
    end
    if matches[6] == "klutymi" then
        equipment.klute = matches[5]
    elseif matches[6] == "cietymi" then
        equipment.ciete = matches[5]
    elseif matches[6] == "obuchowymi" then
        equipment.obuchowe = matches[5]
    end
end

function scripts.inv.equipment.evaluation_extractor:tarcza(equipment, matches)
    equipment.parowanie = matches[3]
end

function trigger_func_skrypty_inventory_equipment_ocena_zbroi()
    scripts.inv.equipment.evaluation_extractor:extract_armor()
end

function trigger_func_skrypty_inventory_equipment_ocena_broni()
    scripts.inv.equipment.evaluation_extractor:extract_weapon()
end
