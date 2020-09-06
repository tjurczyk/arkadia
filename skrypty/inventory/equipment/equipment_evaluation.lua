scripts.inv.equipment.evaluation = scripts.inv.equipment.evaluation or {
    coroutine = nil,
}

function scripts.inv.equipment.evaluation:extract()

end

local armor_types = { "lekka", "srednia", "ciezka", "tarcza" }

function scripts.inv.equipment:replace(equipment)
    local result = {
        values = {}
    }

    result.is_armor = table.contains(armor_types, equipment.type)
    if equipment.parowanie ~= nil then
        equipment.parowanie = string.cut(scripts.inv.equipment.parowanie, string.len(scripts.inv.equipment.parowanie) - 1)
    end

    result.values.klute = scripts.inv.equipment.JakoscZbroi[equipment.klute]
    result.values.ciete = scripts.inv.equipment.JakoscZbroi[equipment.ciete]
    result.values.obuchowe = scripts.inv.equipment.JakoscZbroi[equipment.obuchowe]
    result.values.parowanie = scripts.inv.equipment.SkutecznoscSprzetu[equipment.parowanie]
    result.values.wywazenie = scripts.inv.equipment.WywazenieBroni[equipment.wywazenie]

    if result.is_armor then
        cecho("<light_slate_blue>\n " .. string.sub("Typ zbroi: <grey>" .. scripts.inv.equipment.TypSprzetu .. "                                 ", 0, 50))
        cecho("<light_slate_blue>" .. string.sub("Klute: <grey>" .. scripts.inv.equipment.klute.label .. "                                 ", 0, 46))
        cecho("<light_slate_blue>\n " .. string.sub("Ciete: <grey>" .. scripts.inv.equipment.ciete.label .. "                                 ", 0, 50))
        cecho("<light_slate_blue>" .. string.sub("Obuchowe: <grey>" .. scripts.inv.equipment.obuchowe.label .. "                                 ", 0, 46))
        if equipment.TypSprzetu == "tarcza" then
            cecho("<light_slate_blue>\n " .. string.sub("Parowanie: <grey>" .. scripts.inv.equipment.parowanie.label .. "                                 ", 0, 50))
        end
    else
        if equipment.TypSprzetu == "dwureczny miecz" then
            equipment.TypSprzetu = "miecz"
        end
        cecho("<light_slate_blue>\n " .. string.sub("Typ broni: <grey>" .. scripts.inv.equipment.TypSprzetu .. "                                 ", 0, 40))
        cecho("<light_slate_blue>" .. string.sub("Chwyt: <grey>" .. scripts.inv.equipment.chwytanie .. "                                 ", 0, 40))
        cecho("<light_slate_blue>\n " .. string.sub("Obrazenia: <grey>" .. scripts.inv.equipment.obrazenia .. "                                 ", 0, 50))

        cecho("<light_slate_blue>\n " .. string.sub("Wywazenie: <grey>" .. scripts.inv.equipment.wywazenie.label .. "                                 ", 0, 40))
        cecho("<light_slate_blue>" .. string.sub("Skutecznosc: <grey>" .. scripts.inv.equipment.parowanie.label .. "                                 ", 0, 56))
    end

    raiseEvent("equipmentEvaluation", scripts.inv.equipment)

end

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

function trigger_func_skrypty_inventory_equipment_ocena_broni()
    scripts.inv.equipment.TypSprzetu = matches[2]
    scripts.inv.equipment.wywazenie = matches[5]
    scripts.inv.equipment.parowanie = matches[7]
    deleteLine()
    scripts.inv.equipment.podmien()
end

function trigger_func_skrypty_inventory_equipment_ocena_zbroi()
    deleteLine()
    if matches[3] == "" then
        scripts.inv.equipment.TypSprzetu = "tarcza"
    else
        scripts.inv.equipment.TypSprzetu = matches[3]
    end
end

function trigger_func_skrypty_inventory_equipment_obrazenia()
    deleteLine()
    scripts.inv.equipment.obrazenia = matches[3]
end

function trigger_func_skrypty_inventory_equipment_chwytanie()
    deleteLine()
    scripts.inv.equipment.chwytanie = matches[3]
end