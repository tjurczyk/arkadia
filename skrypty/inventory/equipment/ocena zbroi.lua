function trigger_func_skrypty_inventory_equipment_ocena_zbroi_trzy_rozne()
    if matches[3] == "klutymi" then
        scripts.inv.equipment.klute = matches[2]
    elseif matches[3] == "cietymi" then
        scripts.inv.equipment.ciete = matches[2]
    elseif matches[3] == "obuchowymi" then
        scripts.inv.equipment.obuchowe = matches[2]
    end
    if matches[5] == "klutymi" then
        scripts.inv.equipment.klute = matches[4]
    elseif matches[5] == "cietymi" then
        scripts.inv.equipment.ciete = matches[4]
    elseif matches[5] == "obuchowymi" then
        scripts.inv.equipment.obuchowe = matches[4]
    end
    if matches[7] == "klutymi" then
        scripts.inv.equipment.klute = matches[6]
    elseif matches[7] == "cietymi" then
        scripts.inv.equipment.ciete = matches[6]
    elseif matches[7] == "obuchowymi" then
        scripts.inv.equipment.obuchowe = matches[6]
    end

    if scripts.inv.equipment.TypSprzetu ~= "tarcza" then
        scripts.inv.equipment.podmien()
    end
end

function trigger_func_skrypty_inventory_equipment_ocena_zbroi_trzy_na_raz()
    scripts.inv.equipment.klute = matches[2]
    scripts.inv.equipment.ciete = matches[2]
    scripts.inv.equipment.obuchowe = matches[2]
    if scripts.inv.equipment.TypSprzetu ~= "tarcza" then
        scripts.inv.equipment.podmien()
    end
end

function trigger_func_skrypty_inventory_equipment_ocena_zbroi_2_1()
    if matches[3] == "klutymi" then
        scripts.inv.equipment.klute = matches[2]
    elseif matches[3] == "cietymi" then
        scripts.inv.equipment.ciete = matches[2]
    elseif matches[3] == "obuchowymi" then
        scripts.inv.equipment.obuchowe = matches[2]
    end
    if matches[4] == "klutymi" then
        scripts.inv.equipment.klute = matches[2]
    elseif matches[4] == "cietymi" then
        scripts.inv.equipment.ciete = matches[2]
    elseif matches[4] == "obuchowymi" then
        scripts.inv.equipment.obuchowe = matches[2]
    end
    if matches[6] == "klutymi" then
        scripts.inv.equipment.klute = matches[5]
    elseif matches[6] == "cietymi" then
        scripts.inv.equipment.ciete = matches[5]
    elseif matches[6] == "obuchowymi" then
        scripts.inv.equipment.obuchowe = matches[5]
    end

    if scripts.inv.equipment.TypSprzetu ~= "tarcza" then
        scripts.inv.equipment.podmien()
    end
end

function trigger_func_skrypty_inventory_equipment_ocena_zbroi_tarcza()
    scripts.inv.equipment.parowanie = matches[3]
    scripts.inv.equipment.podmien()
end

