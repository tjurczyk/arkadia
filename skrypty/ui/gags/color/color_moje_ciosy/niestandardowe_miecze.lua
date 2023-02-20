-- Jasniejacy zdobiony jatagan

function trigger_func_skrypty_ui_gags_moje_ciosy_jatagan(value)
    scripts.gags:gag(value, 6, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_jasniejacy_zdobiony_jatagan_inni()
    target = matches["target"] == "cie" and "innych_ciosy_we_mnie" or "innych_ciosy"
    local dmg = matches["damage"]
    local value = -1
        if dmg == "ledwo muska" then value = 1
    elseif dmg == "lekko rani" then value = 2
    elseif dmg == "rani" then value = 3
    elseif dmg == "powaznie rani" then value = 4
    elseif dmg == "bardzo ciezko rani" then value = 5
    elseif dmg == "masakruje" then value = 6 end
    scripts.gags:gag(value, 6, target)
end

-- Espadon

function trigger_func_skrypty_ui_gags_ciosy_espadon(value)
    if line:match("ledwo") then
        return
    end
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 7, target)
end

-- Kruczoczarny miecz

function trigger_func_skrypty_ui_gags_ciosy_kruczoczarny_miecz(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 5, target)
end

-- Arlekiny

function trigger_func_skrypty_ui_gags_ciosy_arlekiny(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 6, target)
end

function trigger_func_skrypty_ui_gags_ciosy_smukly_miecz()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = matches["target"] == "cie" and "innych_ciosy_we_mnie" or "innych_ciosy"
    end

    local dmg = matches["damage"]
    local value = -1
        if dmg == "uderzyc" then value = 0
    elseif dmg == "sparowac" then value = 0
    elseif dmg == "ledwo musnac" then value = 1
    elseif dmg == "lekko zaciac"  then value = 2
    elseif dmg == "mocno" then value = 3
    elseif dmg == "krwawiaca" then value = 4
    elseif dmg == "ciezko rani" then value = 5
    elseif dmg == "rozlegla" then value = 6
    elseif dmg == "zakanczajac" then return trigger_func_skrypty_ui_gags_ciosy_bron_fin()
    end

    trigger_func_skrypty_ui_gags_ciosy_arlekiny(value)
end

-- Szczerba

function trigger_func_skrypty_ui_gags_ciosy_szczerba(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 5, target)
end

function trigger_func_skrypty_ui_gags_spece_szczerba(target)
    scripts.gags:gag_prefix("MIE OGL", line:starts("Dzierzony") and "innych_spece" or "moje_spece")
    ateam:may_setup_paralyzed_name(target)
end

-- Szamszir

function trigger_func_skrypty_ui_gags_ciosy_szamszir(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 6, target)
end

-- Czarny smukly miecz

function trigger_func_skrypty_ui_gags_ciosy_czarny_smukly_miecz()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = matches["target"] == "cie" and "innych_ciosy_we_mnie" or "innych_ciosy"
    end

    local dmg = matches["damage"]
    local value = -1
        if dmg == "kaleczysz" or dmg == "kaleczy" then value = 1
    elseif dmg == "lekko" then value = 2
    elseif dmg == "krwawiaca rane" or dmg == "raniac" then value = 3
    elseif dmg == "powaznie" then value = 4
    elseif dmg == "bardzo ciezko" then value = 5
    elseif dmg == "rozplatujac" then value = 6
    end
    scripts.gags:gag(value, 6, target)
end