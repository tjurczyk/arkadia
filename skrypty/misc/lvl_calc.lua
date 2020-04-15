misc["lvl_calc"] = misc["lvl_calc"] or { current_stats = {}, current_val_to_next = {} }
misc["lvl_calc"]["current_stats"] = {}
misc["lvl_calc"]["current_val_to_next"] = {}

function trigger_func_skrypty_misc_lvl_calc_cechy_ocena()
    misc.lvl_calc:collect_stat_v2(matches[2], matches[3])
end

function trigger_func_skrypty_misc_lvl_calc_cechy_ocena_nadludzie()
    misc.lvl_calc:collect_stat_v2(matches[2])
end

