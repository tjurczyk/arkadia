function trigger_func_skrypty_ui_gags_color_color_innych_spece_bar_ktos_spec_ktos_spec_0()
    scripts.gags:gag_spec("BAR", 0, 6, "innych_spece")
end

function trigger_func_skrypty_ui_gags_color_color_innych_spece_bar_ktos_spec_ktos_spec()
    local value = get_barb_damage_value(matches["damage"])
    scripts.gags:gag_own_spec(value, 6)
    if string.len(matches["stun"]) > 0 then
        scripts.gags:gag_prefix("BAR OGL", "innych_spece")
        ateam:may_setup_paralyzed_name(matches["target"])
    end
end

function trigger_func_skrypty_ui_gags_color_color_innych_spece_bar_ktos_spec_mnie_spec()
    local value = get_barb_damage_value(matches["damage"])
    scripts.gags:gag_own_spec(value, 6)
end

function trigger_func_skrypty_ui_gags_color_color_innych_spece_bar_ktos_spec_ktos_spec_6()
    scripts.gags:gag_spec("BAR", 6, 6, "innych_spece")
end

