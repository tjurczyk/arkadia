function trigger_func_skrypty_ui_gags_color_color_moje_spece_kor_ja_spec_0()
    scripts.gags:gag_own_spec(0, 5)
end

function trigger_func_skrypty_ui_gags_color_color_moje_spece_kor_ja_spec()
    local dmg = matches["damage"]
    local value = -1
        if dmg == "Powol" then value = 1
    elseif dmg == "Oszczed" then value = 2
    elseif dmg == "Zgrab" then value = 3
    elseif dmg == "Plyn" then value = 4
    elseif dmg == "Blyskawicz" then value = 5
        scripts.gags:gag_own_spec(scripts.gags.fin_prefix)
        return
    end
    scripts.gags:gag_own_spec(value, 5)
end
