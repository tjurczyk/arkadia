function trigger_func_skrypty_ui_gags_color_color_innych_spece_str_ktos_wytraca()
    scripts.gags:gag_prefix("STR WYTR", "innych_spece")
end

function trigger_func_skrypty_ui_gags_color_color_innych_spece_str_ktos_spec()
    local dmg = matches["damage"]
    local value = -1
        if dmg == "ledwie zahaczajac" or dmg == "pozostawiajac ledwie sinca" then value = 1
    elseif dmg == "pozostawiajac krwawiace zadrapanie" or dmg == "lekko raniac" then value = 2
    elseif dmg == "pozostawiajac dluga, poszarpana rane" or dmg == "mocno raniac" then value = 3
    elseif dmg == "pozostawiajac gleboka rane z wystajacymi na wierzchu tkankami" or dmg == "bardzo mocno raniac" then value = 4
    elseif dmg == "zadajac smiertelne obrazenia" then value = 5
    elseif dmg:find("lecz impet uderzenia", 1, true) then value = 0
    else end
    local target = scripts.gags:who_hits_attacker_target()
    scripts.gags:gag_spec("STR", value, 5, target)
end

function trigger_func_skrypty_ui_gags_color_color_innych_spece_str_ktos_spec_0()
    scripts.gags:gag_spec("STR", 0, 5, "innych_spece")
end

function trigger_func_skrypty_ui_gags_color_color_innych_spece_str_ktos_spec_1()
    scripts.gags:gag_spec("STR", 1, 5, "innych_spece")
end

function trigger_func_skrypty_ui_gags_color_color_innych_spece_str_ktos_spec_2()
    scripts.gags:gag_spec("STR", 2, 5, "innych_spece")
end

function trigger_func_skrypty_ui_gags_color_color_innych_spece_str_ktos_spec_3()
    scripts.gags:gag_spec("STR", 3, 5, "innych_spece")
end

function trigger_func_skrypty_ui_gags_color_color_innych_spece_str_ktos_spec_4()
    scripts.gags:gag_spec("STR", 4, 5, "innych_spece")
end

function trigger_func_skrypty_ui_gags_color_color_innych_spece_str_ktos_spec_5()
    scripts.gags:gag_spec("STR", 5, 5, "innych_spece")
end

function trigger_func_skrypty_ui_gags_color_color_innych_spece_str_ktos_spec_end()
    scripts.gags:gag_prefix("STR "..scripts.gags.fin_prefix, "innych_spece")
end

