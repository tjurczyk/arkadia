scripts.inv.equipment.JakoscZbroi = {
    ["wyjatkowo zle"] = "wyjatkowo zle [1/12]",
    ["bardzo zle"] = "bardzo zle [2/12]",
    ["zle"] = "zle [3/12]",
    ["bardzo kiepsko"] = "bardzo kiepsko [4/12]",
    ["kiepsko"] = "kiepsko [5/12]",
    ["przyzwoicie"] = "przyzwoicie [6/12]",
    ["niezle"] = "niezle [7/12]",
    ["dosc dobrze"] = "dosc dobrze [8/12]",
    ["dobrze"] = "dobrze [9/12]",
    ["bardzo dobrze"] = "bardzo dobrze [10/12]",
    ["doskonale"] = "doskonale [11/12]",
    ["perfekcyjnie"] = "perfekcyjnie [12/12]"
}

scripts.inv.equipment.SkutecznoscSprzetu = {
    ["kompletnie nieskuteczn"] = "kompletnie nieskuteczne [1/14]",
    ["strasznie nieskuteczn"] = "strasznie nieskuteczne [2/14]",
    ["bardzo nieskuteczn"] = "bardzo nieskuteczne [3/14]",
    ["raczej nieskuteczn"] = "raczej nieskuteczne [4/14]",
    ["malo skuteczn"] = "malo skuteczne [5/14]",
    ["niezbyt skuteczn"] = "niezbyt skuteczne [6/14]",
    ["raczej skuteczn"] = "raczej skuteczne [7/14]",
    ["dosyc skuteczn"] = "dosyc skuteczne [8/14]",
    ["calkiem skuteczn"] = "calkiem skuteczne [9/14]",
    ["bardzo skuteczn"] = "bardzo skuteczne [10/14]",
    ["niezwykle skuteczn"] = "niezwykle skuteczne [11/14]",
    ["wyjatkowo skuteczn"] = "wyjatkowo skuteczne [12/14]",
    ["zabojczo skuteczn"] = "zabojczo skuteczne [13/14]",
    ["fantastycznie skuteczn"] = "fantastycznie skuteczne [14/14]"
}

scripts.inv.equipment.WywazenieBroni = {
    ["wyjatkowo zle"] = "wyjatkowo zle [1/14]",
    ["bardzo zle"] = "bardzo zle [2/14]",
    ["zle"] = "zle [3/14]",
    ["bardzo kiepsko"] = "bardzo kiepsko [4/14]",
    ["kiepsko"] = "kiepsko [5/14]",
    ["przyzwoicie"] = "przyzwoicie [6/14]",
    ["srednio"] = "srednio [7/14]",
    ["niezle"] = "niezle [8/14]",
    ["dosc dobrze"] = "dosc dobrze [9/14]",
    ["dobrze"] = "dobrze [10/14]",
    ["bardzo dobrze"] = "bardzo dobrze [11/14]",
    ["doskonale"] = "doskonale [12/14]",
    ["perfekcyjnie"] = "perfekcyjnie [13/14]",
    ["genialnie"] = "genialnie [14/14]"
}

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

function trigger_func_skrypty_inventory_equipment_ekwipunek_poziom_zuzycia()
    misc:item_used_replace(matches[2])
end

function trigger_func_skrypty_inventory_equipment_poziom_zniszczenia(filtered)
    misc:item_damaged_replace(matches[2], filtered)
end

function trigger_func_skrypty_inventory_equipment_bron_wyryly()
    misc:weapon_damaged_wyryly(matches[1], matches[2])
end

function trigger_func_skrypty_inventory_equipment_ubranie_zbiorcze()
    misc:wear_process_item(multimatches[1][2], multimatches[2][2])
end

function trigger_func_skrypty_inventory_equipment_bronie_zbroje_zbiorcze()
    misc:weapon_item_process_item(multimatches[2][2], multimatches[1][3])
end

function trigger_func_skrypty_inventory_equipment_ubranie_poziom_znoszenia()
    misc:wear_used_replace(matches[2])
end

function trigger_func_skrypty_inventory_equipment_zagladanie_plecaki_zamkniete()
    scripts.inv.containers:display_contents(matches[2])
end

function trigger_func_skrypty_inventory_equipment_zagladanie_plecaki_otwarte()
    scripts.inv.containers:display_contents(matches[4])
end

function trigger_func_skrypty_inventory_equipment_zagladanie_skrzynie()
    scripts.inv.containers:display_contents(matches[2])
end

function trigger_func_skrypty_inventory_equipment_zagladanie_skrzynie1()
    scripts.inv.containers:display_contents(matches[4])
end

function trigger_func_skrypty_inventory_equipment_zagladanie_depozyt()
    scripts.inv.containers:display_contents(matches[2])
end

