function trigger_func_skrypty_ui_gags_color_color_innych_spece_kor_ktos_spec_0()
    scripts.gags:gag_spec("KOR", 0, 5, "innych_spece")
end

function trigger_func_skrypty_ui_gags_color_color_innych_spece_kor_ktos_spec()
    local dmg = matches["damage"]
    local value = -1
    if dmg == "powol" then value = 1
    elseif dmg == "oszczed" then value = 2
    elseif dmg == "zgrab" then value = 3
    elseif dmg == "plyn" then value = 4
    elseif dmg == "blyskawicz" then value = 5
        scripts.gags:gag_prefix("KOR "..scripts.gags.fin_prefix, "innych_spece")
        return
    end
    scripts.gags:gag_spec("KOR", value, 5, "innych_spece")
end

