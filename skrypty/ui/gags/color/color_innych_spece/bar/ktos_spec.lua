function trigger_func_skrypty_ui_gags_color_color_innych_spece_bar_ktos_spec_ktos_spec_0()
    scripts.gags:gag_spec("BAR", 0, 6, "innych_spece")
end

function trigger_func_skrypty_ui_gags_color_color_innych_spece_bar_ktos_spec_ktos_spec()
    local value = get_barb_damage_value(matches["damage"])
    scripts.gags:gag_spec("BAR", value, 6, "innych_spece")
    if string.len(matches["stun"]) > 0 then
        scripts.gags:gag_prefix("BAR OGL", "innych_spece")
        ateam:may_setup_paralyzed_name(matches["target"])
    end
end

function trigger_func_skrypty_ui_gags_color_color_innych_spece_bar_ktos_spec_mnie_spec()
    local value = get_barb_damage_value(matches["damage"])
    scripts.gags:gag_spec("BAR", value, 6, "innych_spece")
end

function trigger_func_skrypty_ui_gags_color_color_innych_spece_bar_ktos_fin()
    scripts.gags:gag_prefix("BAR "..scripts.gags.fin_prefix, "innych_spece")
end
