function misc.stats:add_hits_taken(part, regex)
    if not part or not misc.stats.armor_hit_categories[part] then
        error("part nil or doesn't exist in array")
    end

    misc.stats.armor_hit_categories[part] = misc.stats.armor_hit_categories[part] + 1
    misc.stats.all_hit = misc.stats.all_hit + 1
    misc.stats.hits = misc.stats.hits + 1
    misc.stats:log_cought("add_hits_taken", regex)
end

function misc.stats:add_parry_armor(part, regex)
    if not part or not misc.stats.armor_par_categories[part] then
        error("part nil or doesn't exist in array")
    end

    misc.stats.armor_par_categories[part] = misc.stats.armor_par_categories[part] + 1
    misc.stats.armor_par = misc.stats.armor_par + 1
    misc.stats.all_par = misc.stats.all_par + 1
    misc.stats.hits = misc.stats.hits + 1
    misc.stats:log_cought("add_parry_armor", regex)
end

function misc.stats:add_parry_weapon(regex)
    misc.stats.weapon_par = misc.stats.weapon_par + 1
    misc.stats.all_par = misc.stats.all_par + 1
    misc.stats.hits = misc.stats.hits + 1
    misc.stats:log_cought("add_parry_weapon", regex)
end

function misc.stats:add_parry_shield(regex)
    misc.stats.shield_par = misc.stats.shield_par + 1
    misc.stats.all_par = misc.stats.all_par + 1
    misc.stats.hits = misc.stats.hits + 1
    misc.stats:log_cought("add_parry_shield", regex)
end

function misc.stats:add_dodged(regex)
    misc.stats.dodged = misc.stats.dodged + 1
    misc.stats.hits = misc.stats.hits + 1
    misc.stats:log_cought("add_dodged", regex)
end

function misc.stats:set_verbose(val)
    if val ~= 0 and val ~= 1 and val ~= 2 then
        scripts:print_log("Nie ma takiej opcji, jest 0, 1 albo 2.")
    end

    misc.stats.verbose = val
    scripts:print_log("Ok, ustawiam logowanie na " .. val)
end

function misc.stats:reset_stats()
    misc.stats["hits"] = 0

    misc.stats["armor_hit_categories"] = { ["nogi"] = 0, ["lewe ramie"] = 0, ["prawe ramie"] = 0, ["korpus"] = 0, ["glowe"] = 0 }
    misc.stats["armor_par_categories"] = { ["nogi"] = 0, ["lewe ramie"] = 0, ["prawe ramie"] = 0, ["korpus"] = 0, ["glowe"] = 0 }
    misc.stats["shield_par"] = 0
    misc.stats["dodged"] = 0
    misc.stats["weapon_par"] = 0
    misc.stats["all_par"] = 0
    misc.stats["all_hit"] = 0
    misc.stats["armor_par"] = 0
    scripts:print_log("Ok, staty zresetowane")
end

function misc.stats:log_cought(f_name, regex)
    if misc.stats.verbose == 2 then
        deleteLine()
        scripts:print_log("Staty: wykonalem akcje: " .. f_name .. ", zlapalem: " .. regex, true)
    elseif misc.stats.verbose == 1 then
        deleteLine()
        scripts:print_log("Staty: wykonalem akcje: " .. f_name, true)
    end
end

