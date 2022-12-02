function misc.stats:print_stats()
    cecho("+--------------------- <green>Statystyki<grey> ----------------------+\n")
    cecho("|                                                       |\n")
    local all_hits_str = ".................. " .. string.sub(misc.stats.hits .. "                  ", 0, 18)
    cecho("| <yellow>WSZYSTKIE<grey> ciosy: " .. all_hits_str .. "|\n")

    ------------------------
    -- OGOLEM
    ------------------------

    cecho("|                                                       |\n")
    cecho("| <yellow>OGOLEM<grey> ciosy                                          |\n")

    -- all hits taken
    local all_hit_per = 0
    if misc.stats.hits > 0 and misc.stats.all_hit > 0 then
        all_hit_per = misc.stats.all_hit / misc.stats.hits * 100
    end
    local all_hit_str = ".................... " .. string.sub(misc.stats.all_hit .. " (" .. string.format("%.0f", all_hit_per) .. "%)                ", 0, 18)
    cecho("|   » <light_slate_blue>otrzymane<grey>: " .. all_hit_str .. "|\n")

    -- all pars
    local all_par_per = 0
    if misc.stats.hits > 0 and misc.stats.all_par > 0 then
        all_par_per = misc.stats.all_par / misc.stats.hits * 100
    end
    local all_par_str = "................... " .. string.sub(misc.stats.all_par .. " (" .. string.format("%.0f", all_par_per) .. "%)                 ", 0, 18)
    cecho("|   » <light_slate_blue>wyparowane<grey>: " .. all_par_str .. "|\n")

    -- all dodged
    local all_dod_per = 0
    if misc.stats.hits > 0 and misc.stats.dodged > 0 then
        all_dod_per = misc.stats.dodged / misc.stats.hits * 100
    end
    local all_dod_str = ".................... " .. string.sub(misc.stats.dodged .. " (" .. string.format("%.0f", all_dod_per) .. "%)                 ", 0, 18)
    cecho("|   » <light_slate_blue>unikniete<grey>: " .. all_dod_str .. "|\n")

    ------------------------
    -- OTRZYMANE na czesc ciala
    ------------------------
    cecho("|                                                       |\n")
    cecho("| <yellow>OTRZYMANE<grey> ciosy na czesci ciala                       |\n")

    -- head
    local head_hit_per = 0
    if misc.stats.armor_hit_categories["glowe"] > 0 and misc.stats.all_hit > 0 then
        head_hit_per = misc.stats.armor_hit_categories["glowe"] / misc.stats.all_hit * 100
    end
    local head_hit_str = "........................ " .. string.sub(misc.stats.armor_hit_categories["glowe"] .. " (" .. string.format("%.0f", head_hit_per) .. "%)                ", 0, 18)
    cecho("|   » <light_slate_blue>glowa<grey>: " .. head_hit_str .. "|\n")

    -- shoulders
    local shoulders_hit = misc.stats.armor_hit_categories["prawe ramie"] + misc.stats.armor_hit_categories["lewe ramie"]

    local shoulders_hit_per = 0
    if shoulders_hit > 0 and misc.stats.all_hit > 0 then
        shoulders_hit_per = shoulders_hit / misc.stats.all_hit * 100
    end
    local shoulders_hit_str = "...................... " .. string.sub(shoulders_hit .. " (" .. string.format("%.0f", shoulders_hit_per) .. "%)                ", 0, 18)
    cecho("|   » <light_slate_blue>ramiona<grey>: " .. shoulders_hit_str .. "|\n")

    -- chest
    local chest_hit_per = 0
    if misc.stats.armor_hit_categories["korpus"] > 0 and misc.stats.all_hit > 0 then
        chest_hit_per = misc.stats.armor_hit_categories["korpus"] / misc.stats.all_hit * 100
    end
    local chest_hit_str = "....................... " .. string.sub(misc.stats.armor_hit_categories["korpus"] .. " (" .. string.format("%.0f", chest_hit_per) .. "%)                ", 0, 18)
    cecho("|   » <light_slate_blue>korpus<grey>: " .. chest_hit_str .. "|\n")

    -- legs
    local legs_hit_per = 0
    if misc.stats.armor_hit_categories["nogi"] > 0 and misc.stats.all_hit > 0 then
        legs_hit_per = misc.stats.armor_hit_categories["nogi"] / misc.stats.all_hit * 100
    end
    local legs_hit_str = "......................... " .. string.sub(misc.stats.armor_hit_categories["nogi"] .. " (" .. string.format("%.0f", legs_hit_per) .. "%)                ", 0, 18)
    cecho("|   » <light_slate_blue>nogi<grey>: " .. legs_hit_str .. "|\n")

    ------------------------
    -- WYPAROWANE przez
    ------------------------
    cecho("|                                                       |\n")
    cecho("| <yellow>WYPAROWANE<grey> ciosy przez                                |\n")

    -- weapon
    local all_wea_per = 0
    if misc.stats.weapon_par > 0 and misc.stats.all_par > 0 then
        all_wea_per = misc.stats.weapon_par / misc.stats.all_par * 100
    end
    local all_wea_str = "......................... " .. string.sub(misc.stats.weapon_par .. " (" .. string.format("%.0f", all_wea_per) .. "%)                ", 0, 18)
    cecho("|   » <light_slate_blue>bron<grey>: " .. all_wea_str .. "|\n")

    -- armor
    local all_arm_per = 0
    if misc.stats.armor_par > 0 and misc.stats.all_par > 0 then
        all_arm_per = misc.stats.armor_par / misc.stats.all_par * 100
    end
    local all_arm_str = "....................... " .. string.sub(misc.stats.armor_par .. " (" .. string.format("%.0f", all_arm_per) .. "%)                ", 0, 18)
    cecho("|   » <light_slate_blue>zbroje<grey>: " .. all_arm_str .. "|\n")

    -- shield
    local all_shi_per = 0
    if misc.stats.shield_par > 0 and misc.stats.all_par > 0 then
        all_shi_per = misc.stats.shield_par / misc.stats.all_par * 100
    end
    local all_shi_str = "....................... " .. string.sub(misc.stats.shield_par .. " (" .. string.format("%.0f", all_shi_per) .. "%)                ", 0, 18)
    cecho("|   » <light_slate_blue>tarcze<grey>: " .. all_shi_str .. "|\n")

    ------------------------
    -- WYPAROWANE przez zbroje
    ------------------------
    cecho("|                                                       |\n")
    cecho("| <yellow>WYPAROWANE<grey> ciosy przez zbroje                         |\n")

    -- head
    local head_par_per = 0
    if misc.stats.armor_par_categories["glowe"] > 0 and misc.stats.armor_par > 0 then
        head_par_per = misc.stats.armor_par_categories["glowe"] / misc.stats.armor_par * 100
    end
    local head_par_str = "........................ " .. string.sub(misc.stats.armor_par_categories["glowe"] .. " (" .. string.format("%.0f", head_par_per) .. "%)                ", 0, 18)
    cecho("|   » <light_slate_blue>glowa<grey>: " .. head_par_str .. "|\n")

    -- shoulders
    local shoulders_par = misc.stats.armor_par_categories["prawe ramie"] + misc.stats.armor_par_categories["lewe ramie"]

    local shoulders_par_per = 0
    if shoulders_par > 0 and misc.stats.armor_par > 0 then
        shoulders_par_per = shoulders_par / misc.stats.armor_par * 100
    end
    local shoulders_par_str = "...................... " .. string.sub(shoulders_par .. " (" .. string.format("%.0f", shoulders_par_per) .. "%)                ", 0, 18)
    cecho("|   » <light_slate_blue>ramiona<grey>: " .. shoulders_par_str .. "|\n")

    -- chest
    local chest_par_per = 0
    if misc.stats.armor_par_categories["korpus"] > 0 and misc.stats.armor_par > 0 then
        chest_par_per = misc.stats.armor_par_categories["korpus"] / misc.stats.armor_par * 100
    end
    local chest_par_str = "....................... " .. string.sub(misc.stats.armor_par_categories["korpus"] .. " (" .. string.format("%.0f", chest_par_per) .. "%)                ", 0, 18)
    cecho("|   » <light_slate_blue>korpus<grey>: " .. chest_par_str .. "|\n")

    -- legs
    local legs_par_per = 0
    if misc.stats.armor_par_categories["nogi"] > 0 and misc.stats.armor_par > 0 then
        legs_par_per = misc.stats.armor_par_categories["nogi"] / misc.stats.armor_par * 100
    end
    local legs_par_str = "......................... " .. string.sub(misc.stats.armor_par_categories["nogi"] .. " (" .. string.format("%.0f", legs_par_per) .. "%)                ", 0, 18)
    cecho("|   » <light_slate_blue>nogi<grey>: " .. legs_par_str .. "|\n")

    ------------------------
    -- OTRZYMANE na czesci ciala/WYPAROWANE przez zbroje
    ------------------------
    cecho("|                                                       |\n")
    cecho("| <yellow>OTRZYMANE<grey> na czesci ciala/<yellow>WYPAROWANE<grey> przez zbroje     |\n")

    -- head
    local head_ratio_per = 0
    local head_overall = misc.stats.armor_par_categories["glowe"] + misc.stats.armor_hit_categories["glowe"]
    if head_overall > 0 and misc.stats.armor_hit_categories["glowe"] > 0 then
        head_ratio_per = misc.stats.armor_hit_categories["glowe"] / head_overall * 100
    end
    local head_ratio_str = "....... " .. string.sub(misc.stats.armor_hit_categories["glowe"] .. " (" .. string.format("%.0f", head_ratio_per) .. "%) / " .. misc.stats.armor_par_categories["glowe"] .. " (" .. string.format("%.0f", (100 - head_ratio_per)) .. "%)                    ", 0, 35)
    cecho("|   » <light_slate_blue>glowa<grey>: " .. head_ratio_str .. "|\n")

    -- shoulders
    local shoulders_overall = shoulders_hit + shoulders_par

    local shoulders_ratio_per = 0
    if shoulders_overall > 0 and shoulders_hit > 0 then
        shoulders_ratio_per = shoulders_hit / shoulders_overall * 100
    end
    local shoulders_ratio_str = "..... " .. string.sub(shoulders_hit .. " (" .. string.format("%.0f", shoulders_ratio_per) .. "%) / " .. shoulders_par .. " (" .. string.format("%.0f", (100 - shoulders_ratio_per)) .. "%)                       ", 0, 35)
    cecho("|   » <light_slate_blue>ramiona<grey>: " .. shoulders_ratio_str .. "|\n")

    -- chest
    local chest_ratio_per = 0
    local chest_overall = misc.stats.armor_par_categories["korpus"] + misc.stats.armor_hit_categories["korpus"]
    if chest_overall > 0 and misc.stats.armor_hit_categories["korpus"] > 0 then
        chest_ratio_per = misc.stats.armor_hit_categories["korpus"] / chest_overall * 100
    end
    local chest_ratio_str = "...... " .. string.sub(misc.stats.armor_hit_categories["korpus"] .. " (" .. string.format("%.0f", chest_ratio_per) .. "%) / " .. misc.stats.armor_par_categories["korpus"] .. " (" .. string.format("%.0f", (100 - chest_ratio_per)) .. "%)                    ", 0, 35)
    cecho("|   » <light_slate_blue>korpus<grey>: " .. chest_ratio_str .. "|\n")

    -- legs
    local legs_ratio_per = 0
    local legs_overall = misc.stats.armor_par_categories["nogi"] + misc.stats.armor_hit_categories["nogi"]
    if legs_overall > 0 and misc.stats.armor_hit_categories["nogi"] > 0 then
        legs_ratio_per = misc.stats.armor_hit_categories["nogi"] / legs_overall * 100
    end
    local legs_ratio_str = "........ " .. string.sub(misc.stats.armor_hit_categories["nogi"] .. " (" .. string.format("%.0f", legs_ratio_per) .. "%) / " .. misc.stats.armor_par_categories["nogi"] .. " (" .. string.format("%.0f", (100 - legs_ratio_per)) .. "%)                    ", 0, 35)
    cecho("|   » <light_slate_blue>nogi<grey>: " .. legs_ratio_str .. "|\n")
    cecho("|                                                       |\n")
    cecho("+-------------------------------------------------------+\n")
end

-- Alternatywne wyswietlanie statow
function misc.stats:print_stats2()
    cecho("+--------------------- <green>Statystyki<grey> ----------------------+\n")
    cecho("|                                                       |\n")
    local all_hits_str = ".................. " .. string.sub(misc.stats.hits .. "                  ", 0, 18)
    cecho("| <yellow>WSZYSTKIE<grey> ciosy: " .. all_hits_str .. "|\n")

    ------------------------
    -- OGOLEM
    ------------------------
    local stat_taken = 0
    local stat_dodged = 0
    local stat_parry = 0
    local stat_shield = 0
    local stat_armor = 0
    if misc.stats.all_hit > 0 then
        stat_taken = misc.stats.all_hit / misc.stats.hits * 100 -- otrzymane
        stat_dodged = misc.stats.dodged / misc.stats.hits * 100 -- unikniete
        stat_parry = misc.stats.weapon_par / misc.stats.hits * 100 -- sparowane bronia
        stat_shield = misc.stats.shield_par / misc.stats.hits * 100 -- osloniete tarcza
        stat_armor = misc.stats.armor_par / misc.stats.hits * 100 -- wyparowane przez zbroje
    end

    cecho("|                                                       |\n")
    cecho("| <yellow>STATYSTYKI OGOLNE<grey>                                     |\n")
    cecho("|                                                       |\n")
    cecho("|   » <light_slate_blue>Otrzymane: <grey>" .. ".................... " .. string.sub(misc.stats.all_hit .. "/" .. misc.stats.hits .. " (" .. string.format("%.0f", stat_taken) .. "%)" .. "            ", 0, 18) .. "|\n")
    cecho("|                                                       |\n")
    cecho("|   » <light_slate_blue>Uniki: <grey>" .. "........................ " .. string.sub(misc.stats.dodged .. "/" .. misc.stats.hits .. " (" .. string.format("%.0f", stat_dodged) .. "%)" .. "            ", 0, 18) .. "|\n")
    cecho("|   » <light_slate_blue>Parowanie: <grey>" .. ".................... " .. string.sub(misc.stats.weapon_par .. "/" .. misc.stats.hits .. " (" .. string.format("%.0f", stat_parry) .. "%)" .. "            ", 0, 18) .. "|\n")
    cecho("|   » <light_slate_blue>Tarcza: <grey>" .. "....................... " .. string.sub(misc.stats.shield_par .. "/" .. misc.stats.hits .. " (" .. string.format("%.0f", stat_shield) .. "%)" .. "            ", 0, 18) .. "|\n")
    cecho("|   » <light_slate_blue>Zbroja: <grey>" .. "....................... " .. string.sub(misc.stats.armor_par .. "/" .. misc.stats.hits .. " (" .. string.format("%.0f", stat_armor) .. "%)" .. "            ", 0, 18) .. "|\n")
    cecho("|                                                       |\n")
    ------------------------
    -- ZBROJA
    ------------------------  
    local stat_armor_head = 0
    local stat_armor_head_all = misc.stats.armor_par_categories["glowe"] + misc.stats.armor_hit_categories["glowe"]
    if stat_armor_head_all > 0 then
        stat_armor_head = misc.stats.armor_par_categories["glowe"] / stat_armor_head_all * 100 -- % stat glowa
    end
    local stat_armor_lshoulder = 0
    local stat_armor_lshoulder_all = misc.stats.armor_par_categories["lewe ramie"] + misc.stats.armor_hit_categories["lewe ramie"]
    if stat_armor_lshoulder_all > 0 then
        stat_armor_lshoulder = misc.stats.armor_par_categories["lewe ramie"] / stat_armor_lshoulder_all * 100 -- % stat lewe ramie
    end
    local stat_armor_rshoulder = 0
    local stat_armor_rshoulder_all = misc.stats.armor_par_categories["prawe ramie"] + misc.stats.armor_hit_categories["prawe ramie"]
    if stat_armor_rshoulder_all > 0 then
        stat_armor_rshoulder = misc.stats.armor_par_categories["prawe ramie"] / stat_armor_rshoulder_all * 100 -- % stat lewe ramie
    end
    local stat_armor_chest = 0
    local stat_armor_chest_all = misc.stats.armor_par_categories["korpus"] + misc.stats.armor_hit_categories["korpus"]
    if stat_armor_chest_all > 0 then
        stat_armor_chest = misc.stats.armor_par_categories["korpus"] / stat_armor_chest_all * 100 -- % stat korpus
    end
    local stat_armor_legs = 0
    local stat_armor_legs_all = misc.stats.armor_par_categories["nogi"] + misc.stats.armor_hit_categories["nogi"]
    if stat_armor_legs_all > 0 then
        stat_armor_legs = misc.stats.armor_par_categories["nogi"] / stat_armor_legs_all * 100 -- % stat nogi
    end

    cecho("| <yellow>STATYSTYKI ZBROI<grey>                                      |\n")
    cecho("|                                                       |\n")
    cecho("|   » <light_slate_blue>Glowa: <grey>" .. "....................... " .. string.sub(misc.stats.armor_par_categories["glowe"] .. "/" .. stat_armor_head_all .. " (" .. string.format("%.0f", stat_armor_head) .. "%)" .. "            ", 0, 19) .. "|\n")
    cecho("|   » <light_slate_blue>Lewe ramie: <grey>" .. ".................. " .. string.sub(misc.stats.armor_par_categories["lewe ramie"].. "/" .. stat_armor_lshoulder_all .. " (" .. string.format("%.0f", stat_armor_lshoulder) .. "%)" .. "            ", 0, 19) .. "|\n")
    cecho("|   » <light_slate_blue>Prawe ramie: <grey>" .. "................. " .. string.sub(misc.stats.armor_par_categories["prawe ramie"].. "/" .. stat_armor_rshoulder_all .. " (" .. string.format("%.0f", stat_armor_rshoulder) .. "%)" .. "            ", 0, 19) .. "|\n")
    cecho("|   » <light_slate_blue>Korpus: <grey>" .. "...................... " .. string.sub(misc.stats.armor_hit_categories["korpus"] .. "/" .. stat_armor_chest_all .. " (" .. string.format("%.0f", stat_armor_chest) .. "%)" .. "            ", 0, 19) .. "|\n")
    cecho("|   » <light_slate_blue>Nogi: <grey>" .. "........................ " .. string.sub(misc.stats.armor_par_categories["nogi"] .. "/" .. stat_armor_legs_all .. " (" .. string.format("%.0f", stat_armor_legs) .. "%)" .. "            ", 0, 19) .. "|\n")
    cecho("|                                                       |\n")
    ------------------------
    -- CZESCI CIALA
    ------------------------  
    local stat_hit_head = 0
    local stat_hit_lshoulder = 0
    local stat_hit_rshoulder = 0
    local stat_hit_chest = 0
    local stat_hit_legs = 0
    local stat_all_hits = (misc.stats.all_hit + misc.stats.armor_par)
    if stat_all_hits > 0 then
        stat_hit_head = stat_armor_head_all / stat_all_hits * 100
        stat_hit_lshoulder = stat_armor_lshoulder_all / stat_all_hits * 100
        stat_hit_rshoulder = stat_armor_rshoulder_all / stat_all_hits * 100
        stat_hit_chest = stat_armor_chest_all / stat_all_hits * 100
        stat_hit_legs = stat_armor_legs_all / stat_all_hits * 100
    end
    cecho("| <yellow>STATYSTYKI<grey> ciosy na czesci ciala                      |\n")
    cecho("|                                                       |\n")
    cecho("|   » <light_slate_blue>Glowa: <grey>" .. "....................... " .. string.sub(stat_armor_head_all .. "/" .. stat_all_hits .. " (" .. string.format("%.0f", stat_hit_head) .. "%)" .. "            ", 0, 19) .. "|\n")
    cecho("|   » <light_slate_blue>Lewe ramie: <grey>" .. ".................. " .. string.sub(stat_armor_lshoulder_all.. "/" .. stat_all_hits .. " (" .. string.format("%.0f", stat_hit_lshoulder) .. "%)" .. "            ", 0, 19) .. "|\n")
    cecho("|   » <light_slate_blue>Prawe ramie: <grey>" .. "................. " .. string.sub(stat_armor_rshoulder_all.. "/" .. stat_all_hits .. " (" .. string.format("%.0f", stat_hit_rshoulder) .. "%)" .. "            ", 0, 19) .. "|\n")
    cecho("|   » <light_slate_blue>Korpus: <grey>" .. "...................... " .. string.sub(stat_armor_chest_all .. "/" .. stat_all_hits .. " (" .. string.format("%.0f", stat_hit_chest) .. "%)" .. "            ", 0, 19) .. "|\n")
    cecho("|   » <light_slate_blue>Nogi: <grey>" .. "........................ " .. string.sub(stat_armor_legs_all .. "/" .. stat_all_hits .. " (" .. string.format("%.0f", stat_hit_legs) .. "%)" .. "            ", 0, 19) .. "|\n")
    cecho("|                                                       |\n")
    cecho("+-------------------------------------------------------+\n")
end

