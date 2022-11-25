-- Czarny smukly kordelas

function trigger_func_skrypty_ui_gags_ciosy_czarny_smukly_kordelas()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = matches["target"] == "cie" and "innych_ciosy_we_mnie" or "innych_ciosy"
    end

    local dmg = matches["damage"]
    local value = -1
        if dmg == "trafiajac" then value = 1
    elseif dmg == "zamach" then value = 3
    elseif dmg == "powaznie" then value = 4
    elseif dmg == "bardzo ciezko" then value = 5
    elseif dmg == "poszarpana rane" then value = 6
    end
    scripts.gags:gag(value, 6, target)
end