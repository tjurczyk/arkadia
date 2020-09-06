scripts.inv.equipment.JakoscZbroi = {
    ["wyjatkowo zle"] = { value = 1, label = "wyjatkowo zle [1/12]" },
    ["bardzo zle"] = { value = 2, label = "bardzo zle [2/12]" },
    ["zle"] = { value = 3, label = "zle [3/12]" },
    ["bardzo kiepsko"] = { value = 4, label = "bardzo kiepsko [4/12]" },
    ["kiepsko"] = { value = 5, label = "kiepsko [5/12]" },
    ["przyzwoicie"] = { value = 6, label = "przyzwoicie [6/12]" },
    ["niezle"] = { value = 7, label = "niezle [7/12]" },
    ["dosc dobrze"] = { value = 8, label = "dosc dobrze [8/12]" },
    ["dobrze"] = { value = 9, label = "dobrze [9/12]" },
    ["bardzo dobrze"] = { value = 10, label = "bardzo dobrze [10/12]" },
    ["doskonale"] = { value = 11, label = "doskonale [11/12]" },
    ["perfekcyjnie"] = { value = 12, label = "perfekcyjnie [12/12]" }
}

scripts.inv.equipment.SkutecznoscSprzetu = {
    ["kompletnie nieskuteczn"] = { value = 1, label = "kompletnie nieskuteczne [1/14]" },
    ["strasznie nieskuteczn"] = { value = 2, label = "strasznie nieskuteczne [2/14]" },
    ["bardzo nieskuteczn"] = { value = 3, label = "bardzo nieskuteczne [3/14]" },
    ["raczej nieskuteczn"] = { value = 4, label = "raczej nieskuteczne [4/14]" },
    ["malo skuteczn"] = { value = 5, label = "malo skuteczne [5/14]" },
    ["niezbyt skuteczn"] = { value = 6, label = "niezbyt skuteczne [6/14]" },
    ["raczej skuteczn"] = { value = 7, label = "raczej skuteczne [7/14]" },
    ["dosyc skuteczn"] = { value = 8, label = "dosyc skuteczne [8/14]" },
    ["calkiem skuteczn"] = { value = 9, label = "calkiem skuteczne [9/14]" },
    ["bardzo skuteczn"] = { value = 10, label = "bardzo skuteczne [10/14]" },
    ["niezwykle skuteczn"] = { value = 11, label = "niezwykle skuteczne [11/14]" },
    ["wyjatkowo skuteczn"] = { value = 12, label = "wyjatkowo skuteczne [12/14]" },
    ["zabojczo skuteczn"] = { value = 13, label = "zabojczo skuteczne [13/14]" },
    ["fantastycznie skuteczn"] = { value = 14, label = "fantastycznie skuteczne [14/14]" }
}

scripts.inv.equipment.WywazenieBroni = {
    ["wyjatkowo zle"] = { value = 1, label = "wyjatkowo zle [1/14]" },
    ["bardzo zle"] = { value = 2, label = "bardzo zle [2/14]" },
    ["zle"] = { value = 3, label = "zle [3/14]" },
    ["bardzo kiepsko"] = { value = 4, label = "bardzo kiepsko [4/14]" },
    ["kiepsko"] = { value = 5, label = "kiepsko [5/14]" },
    ["przyzwoicie"] = { value = 6, label = "przyzwoicie [6/14]" },
    ["srednio"] = { value = 7, label = "srednio [7/14]" },
    ["niezle"] = { value = 8, label = "niezle [8/14]" },
    ["dosc dobrze"] = { value = 9, label = "dosc dobrze [9/14]" },
    ["dobrze"] = { value = 10, label = "dobrze [10/14]" },
    ["bardzo dobrze"] = { value = 11, label = "bardzo dobrze [11/14]" },
    ["doskonale"] = { value = 12, label = "doskonale [12/14]" },
    ["perfekcyjnie"] = { value = 13, label = "perfekcyjnie [13/14]" },
    ["genialnie"] = { value = 14, label = "genialnie [14/14]" }
}

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

