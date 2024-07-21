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
        if dmg == "uderzyc" or dmg == "probujesz" or dmg == "sparowac" then value = 0
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

-- Srebrny wiedzminski miecz dwureczny

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_wiedzminski_ja_ledwo_muska()
    scripts.gags:gag(1, 7, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_wiedzminski_ja_lekko_rani()
    scripts.gags:gag(2, 7, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_wiedzminski_ja_rani()
    scripts.gags:gag(3, 7, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_wiedzminski_ja_powaznie_rani()
    scripts.gags:gag(4, 7, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_wiedzminski_ja_bardzo_ciezko_rani()
    scripts.gags:gag(5, 7, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_wiedzminski_ja_masakruje()
    scripts.gags:gag(6, 7, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_wiedzminski_ja_masakruje1()
    scripts.gags:gag(7, 7, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_ciosy_srebrny_wiedzminski_miecz_dwureczny()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = matches["target"] == "cie" and "innych_ciosy_we_mnie" or "innych_ciosy"
    end
    local dmg = matches["damage"]
    local value = -1
    scripts.gags:gag(value, 6, target)
end

-- Waski kunsztowny sihill
function trigger_func_skrypty_ui_gags_ciosy_waski_kunsztowny_sihill()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = (matches["target"] == "cie" or matches["target"] == "ciebie") and "innych_ciosy_we_mnie" or "innych_ciosy"
    end

    local dmg = matches["damage"]
    local value = -1
        if dmg == "obok" or dmg == "niezgrabnym" then value = 0
    elseif dmg == "nieznaczne" or dmg =="tnac"  then value = 1
    elseif dmg == "lekko raniac" then value = 2
    elseif dmg == "raniac" then value = 3
    elseif dmg == "wbija" then value = 4
    elseif dmg == "ogromne" then value = 5
    elseif dmg == "bryzg" then return trigger_func_skrypty_ui_gags_ciosy_bron_fin()
    end
    scripts.gags:gag(value, 6, target)
end

-- Gorejacy dlugi talwar
function trigger_func_skrypty_ui_gags_ciosy_gorejacy_dlugi_talwar()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = (matches["target"] == "cie" or matches["target"] == "ciebie") and "innych_ciosy_we_mnie" or "innych_ciosy"
    end

    local dmg = matches["damage"]
    local value = -1
        if dmg == "" then value = 0
    elseif dmg == "parzac"  then value = 1
    elseif dmg == "spore" then value = 2
    elseif dmg == "wybucha" then value = 3
    elseif dmg == "olbrzymim" then trigger_func_skrypty_ui_gags_ciosy_bron_fin()
    end
    scripts.gags:gag(value, 6, target)
end

-- Rapier

function trigger_func_skrypty_ui_gags_ciosy_rapier()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = (matches["target"] == "cie" or matches["target"] == "ciebie") and "innych_ciosy_we_mnie" or "innych_ciosy"
    end

    local dmg = matches["damage"]
    local value = -1
        if dmg == "dluga" then value = 1
    elseif dmg == "gleboka"  then value = 2
    elseif dmg == "krwawiaca" then value = 3
    elseif dmg == "poszarpana" then value = 4
    elseif dmg == "poszarpana, krwawiaca" then value = 5
    elseif dmg == "przebija" then value = 6
    end
    scripts.gags:gag(value, 6, target)
end
