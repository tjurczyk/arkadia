function trigger_func_skrypty_ui_gags_color_color_innych_spece_kor_ktos_spec_0()
    local target = matches["target"] and "innych_spece" or "innych_spece_we_mnie"
    scripts.gags:gag_spec("KOR", 0, 5, target)
end

function trigger_func_skrypty_ui_gags_color_color_innych_spece_kor_ktos_spec()
    local target = (matches["target"] == "cie" or matches["target"] == "twego") and "innych_spece_we_mnie" or "innych_spece"
    local dmg = matches["damage"]
    local value = -1
    if dmg == "powol" then value = 1
    elseif dmg == "oszczed" then value = 2
    elseif dmg == "zgrab" then value = 3
    elseif dmg == "plyn" then value = 4
    elseif dmg == "blyskawicz" then value = 5
        scripts.gags:gag_prefix("KOR FIN", target)
        return
    end
    scripts.gags:gag_spec("KOR", value, 5, target)
end

