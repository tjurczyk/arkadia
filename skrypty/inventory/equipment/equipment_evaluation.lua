scripts.inv.equipment.evaluation = scripts.inv.equipment.evaluation or {
    coroutine = nil,
}

function scripts.inv.equipment.evaluation:extract()

end

local armor_types = { "lekka", "srednia", "ciezka", "tarcza" }

function scripts.inv.equipment:replace(equipment)
    display(equipment)
    equipment.is_armor = table.contains(armor_types, equipment.typSprzetu)
    if equipment.parowanie ~= nil then
        equipment.parowanie = string.cut(equipment.parowanie, string.len(equipment.parowanie) - 1)
    end

    equipment.klute = scripts.inv.equipment.JakoscZbroi[equipment.klute]
    equipment.ciete = scripts.inv.equipment.JakoscZbroi[equipment.ciete]
    equipment.obuchowe = scripts.inv.equipment.JakoscZbroi[equipment.obuchowe]
    equipment.parowanie = scripts.inv.equipment.SkutecznoscSprzetu[equipment.parowanie]
    equipment.wywazenie = scripts.inv.equipment.WywazenieBroni[equipment.wywazenie]

    if equipment.is_armor then
        cecho("<light_slate_blue>\n " .. string.sub("Typ zbroi: <grey>" .. equipment.typSprzetu .. "                                 ", 0, 50))
        cecho("<light_slate_blue>" .. string.sub("Klute: <grey>" .. equipment.klute.label .. "                                 ", 0, 46))
        cecho("<light_slate_blue>\n " .. string.sub("Ciete: <grey>" .. equipment.ciete.label .. "                                 ", 0, 50))
        cecho("<light_slate_blue>" .. string.sub("Obuchowe: <grey>" .. equipment.obuchowe.label .. "                                 ", 0, 46))
        if equipment.typSprzetu == "tarcza" and equipment.parowanie then
            cecho("<light_slate_blue>\n " .. string.sub("Parowanie: <grey>" .. equipment.parowanie.label .. "                                 ", 0, 50))
        end
    else
        if equipment.typSprzetu == "dwureczny miecz" then
            equipment.typSprzetu = "miecz"
        end
        cecho("<light_slate_blue>\n " .. string.sub("Typ broni: <grey>" .. equipment.TypSprzetu .. "                                 ", 0, 40))
        cecho("<light_slate_blue>" .. string.sub("Chwyt: <grey>" .. equipment.chwytanie .. "                                 ", 0, 40))
        cecho("<light_slate_blue>\n " .. string.sub("Obrazenia: <grey>" .. equipment.obrazenia .. "                                 ", 0, 50))

        cecho("<light_slate_blue>\n " .. string.sub("Wywazenie: <grey>" .. equipment.wywazenie.label .. "                                 ", 0, 40))
        cecho("<light_slate_blue>" .. string.sub("Skutecznosc: <grey>" .. equipment.parowanie.label .. "                                 ", 0, 56))
    end

    raiseEvent("equipmentEvaluation", equipment)

end