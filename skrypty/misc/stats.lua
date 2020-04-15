misc.stats["verbose"] = 0
misc.stats["hits"] = 0

misc.stats["armor_hit_categories"] = { ["nogi"] = 0, ["lewe ramie"] = 0, ["prawe ramie"] = 0, ["korpus"] = 0, ["glowe"] = 0 }
misc.stats["armor_par_categories"] = { ["nogi"] = 0, ["lewe ramie"] = 0, ["prawe ramie"] = 0, ["korpus"] = 0, ["glowe"] = 0 }
misc.stats["shield_par"] = 0
misc.stats["dodged"] = 0
misc.stats["weapon_par"] = 0
misc.stats["all_par"] = 0
misc.stats["all_hit"] = 0
misc.stats["armor_par"] = 0

function trigger_func_skrypty_misc_stats_parry_armor()
    misc.stats:add_parry_armor(matches[3], matches[2])
end

function trigger_func_skrypty_misc_stats_parry_weapon()
    misc.stats:add_parry_weapon(matches[2])
end

function trigger_func_skrypty_misc_stats_parry_shield()
    misc.stats:add_parry_shield(matches[2])
end

function trigger_func_skrypty_misc_stats_hits_taken()
    misc.stats:add_hits_taken(matches[3], matches[2])
end

function trigger_func_skrypty_misc_stats_dodged()
    misc.stats:add_dodged(matches[2])
end

