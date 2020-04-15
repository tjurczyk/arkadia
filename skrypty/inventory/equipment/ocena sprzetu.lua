--
-- Ocena sprzetu (triggery + ten skrypt) autorstwa Farandara
--

function scripts.inv.equipment:podmien()
    local is_armor = nil
    if scripts.inv.equipment.TypSprzetu == "lekka" or
            scripts.inv.equipment.TypSprzetu == "ciezka" or
            scripts.inv.equipment.TypSprzetu == "srednia" or
            scripts.inv.equipment.TypSprzetu == "tarcza" then
        is_armor = true
        if scripts.inv.equipment.parowanie ~= nil then
            scripts.inv.equipment.parowanie = string.cut(scripts.inv.equipment.parowanie, string.len(scripts.inv.equipment.parowanie) - 1)
        end
    else
        is_armor = false
        scripts.inv.equipment.parowanie = string.cut(scripts.inv.equipment.parowanie, string.len(scripts.inv.equipment.parowanie) - 1)
    end

    scripts.inv.equipment.klute = scripts.inv.equipment.JakoscZbroi[scripts.inv.equipment.klute]
    scripts.inv.equipment.ciete = scripts.inv.equipment.JakoscZbroi[scripts.inv.equipment.ciete]
    scripts.inv.equipment.obuchowe = scripts.inv.equipment.JakoscZbroi[scripts.inv.equipment.obuchowe]
    scripts.inv.equipment.parowanie = scripts.inv.equipment.SkutecznoscSprzetu[scripts.inv.equipment.parowanie]
    scripts.inv.equipment.wywazenie = scripts.inv.equipment.WywazenieBroni[scripts.inv.equipment.wywazenie]

    if is_armor then
        cecho("<light_slate_blue>\n " .. string.sub("Typ zbroi: <grey>" .. scripts.inv.equipment.TypSprzetu .. "                                 ", 0, 50))
        cecho("<light_slate_blue>" .. string.sub("Klute: <grey>" .. scripts.inv.equipment.klute .. "                                 ", 0, 46))
        cecho("<light_slate_blue>\n " .. string.sub("Ciete: <grey>" .. scripts.inv.equipment.ciete .. "                                 ", 0, 50))
        cecho("<light_slate_blue>" .. string.sub("Obuchowe: <grey>" .. scripts.inv.equipment.obuchowe .. "                                 ", 0, 46))
        if scripts.inv.equipment.TypSprzetu == "tarcza" then
            cecho("<light_slate_blue>\n " .. string.sub("Parowanie: <grey>" .. scripts.inv.equipment.parowanie .. "                                 ", 0, 50))
        end
    else
        if scripts.inv.equipment.TypSprzetu == "dwureczny miecz" then
            scripts.inv.equipment.TypSprzetu = "miecz"
        end
        cecho("<light_slate_blue>\n " .. string.sub("Typ broni: <grey>" .. scripts.inv.equipment.TypSprzetu .. "                                 ", 0, 40))
        cecho("<light_slate_blue>" .. string.sub("Chwyt: <grey>" .. scripts.inv.equipment.chwytanie .. "                                 ", 0, 40))
        cecho("<light_slate_blue>\n " .. string.sub("Obrazenia: <grey>" .. scripts.inv.equipment.obrazenia .. "                                 ", 0, 50))

        cecho("<light_slate_blue>\n " .. string.sub("Wywazenie: <grey>" .. scripts.inv.equipment.wywazenie .. "                                 ", 0, 40))
        cecho("<light_slate_blue>" .. string.sub("Skutecznosc: <grey>" .. scripts.inv.equipment.parowanie .. "                                 ", 0, 56))
    end
    --scripts.inv.equipment.dodatkowe = nil
end

