-- Obosieczny gwiezdny topor

function trigger_func_skrypty_ui_gags_ciosy_obosieczny_gwiezdny_topor()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = matches["target"] == "twoje cialo" and "innych_ciosy_we_mnie" or "innych_ciosy"
    end
    local dmg = matches["damage"]
    local value = -1
        if dmg == "tnie plytko" then value = 1
    elseif dmg == "tnie lekko" then value = 2
    elseif dmg == "tnie gladko" then value = 3
    elseif dmg == "tnie szeroko" then value = 4
    elseif dmg == "tnie gleboko" then value = 5
    elseif dmg == "niemal przecina w pol" then value = 6
    else end
    scripts.gags:gag(value, 6, target)
end

-- Misterny obosieczny topor bojowy

function trigger_func_skrypty_ui_gags_ciosy_kunsztowny_mithrylowy_topor_bojowy()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = matches["target"] == "twoje cialo" and "innych_ciosy_we_mnie" or "innych_ciosy"
    end
    local dmg = matches["damage"]
    local value = -1
        if dmg == "uskakuje"  then value = 0
    elseif dmg == "dotyka"    then value = 1
    elseif dmg == "rani" or dmg == "rabie" or dmg == "ciezkie"  then value = 2
    elseif dmg == "kosci"     then value = 3
    elseif dmg == "tnie"    then value = 4
    elseif dmg == "trafia"    then value = 5
    elseif dmg == "druzgocze" then value = 6
    end
    scripts.gags:gag(value, 6, target)
end

-- Czarny smukly topor

function trigger_func_skrypty_ui_gags_ciosy_czarny_smukly_topor()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = matches["target"] == "cie" and "innych_ciosy_we_mnie" or "innych_ciosy"
    end

    local dmg = matches["damage"]
    local value = -1
        if dmg == "Kaleczysz" or dmg == "kaleczy" then value = 1
    elseif dmg == "lekko" then value = 2
    elseif dmg == "Ranisz" then value = 3
    elseif dmg == "powaznie" then value = 4
    elseif dmg == "bardzo ciezko" then value = 5
    elseif dmg == "upadajac" then value = 6
    end
    scripts.gags:gag(value, 6, target)
end