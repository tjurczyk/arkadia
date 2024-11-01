function get_barb_damage_value(dmg)
        if dmg == "kaleczac" or dmg == "muskajac" then return 1
    elseif dmg == "obijajac" or dmg == "lekko raniac" then return 2
    elseif dmg == "tlukac"   or dmg == "raniac"  then return 3
    elseif dmg == "gruchoczac" or dmg == "powaznie raniac" then return 4
    elseif dmg == "druzgoczac" or dmg == "bardzo ciezko raniac" then return 5
    elseif dmg == "miazdzac" or dmg == "masakrujac"   then return 6
    else
        return -1
    end
end

function trigger_func_skrypty_ui_gags_color_color_moje_spece_bar_ja_spec_ja_spec_0()
    scripts.gags:gag_own_spec(0, 6)
end

function trigger_func_skrypty_ui_gags_color_color_moje_spece_bar_ja_spec()
    local value = get_barb_damage_value(matches["damage"])
    scripts.gags:gag_own_spec(value, 6)
    if string.len(matches["stun"]) > 0 then
        trigger_func_skrypty_ui_gags_color_color_moje_spece_bar_ja_spec_ja_ogluch()
    end
end

function trigger_func_skrypty_ui_gags_color_color_moje_spece_bar_ja_fin()
    scripts.gags:gag_prefix("JA "..scripts.gags.fin_prefix, "moje_spece")
end

function trigger_func_skrypty_ui_gags_color_color_moje_spece_bar_ja_spec_ja_ogluch()
    scripts.gags:gag_own_spec("OGL")
    ateam:may_setup_paralyzed_name(matches["target"])
end


