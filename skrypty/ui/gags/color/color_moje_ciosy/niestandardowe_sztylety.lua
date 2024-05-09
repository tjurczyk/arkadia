-- Antyczny zdobiony sztylet

function trigger_func_skrypty_ui_gags_ciosy_antyczny_sztylet()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = matches["target"] == "cie" and "innych_ciosy_we_mnie" or "innych_ciosy"
    end

    local dmg = matches["damage"]
    local value = -1
        if dmg == "zadnej" then value = 0
    elseif dmg == "podluzna, niezbyt szeroka bruzde" then value = 1
    elseif dmg == "podluzna, dosyc szeroka bruzde" then value = 2
    elseif dmg == "poszarpana, dosyc szeroka bruzde" then value = 3
    elseif dmg == "poszarpana, bardzo gleboka bruzde" then value = 4
    elseif dmg == "potwornie poszarpana, gleboka bruzde" then value = 5
    elseif dmg == "potwornie poszarpana, bardzo gleboka bruzde" then value = 6
    end
    scripts.gags:gag(value, 6, target)
end

-- Czarny smukly kordelas

function trigger_func_skrypty_ui_gags_ciosy_czarny_smukly_kordelas()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = matches["target"] == "cie" and "innych_ciosy_we_mnie" or "innych_ciosy"
    end

    local dmg = matches["damage"]
    local value = -1
        if dmg == "trafiajac" then value = 1
    elseif dmg == "raniac"  then value = 2
    elseif dmg == "zamach" then value = 3
    elseif dmg == "powaznie" then value = 4
    elseif dmg == "bardzo ciezko" then value = 5
    elseif dmg == "poszarpana rane" then value = 6
    end
    scripts.gags:gag(value, 6, target)
end

function trigger_func_skrypty_ui_gags_ciosy_czarny_smukly_kordelas_moje()
    local target = "moje_ciosy"
    local dmg = matches["damage"]
    local value = -1
    
        if dmg == "nie wyrzadza"  then value = 0
    elseif dmg == "Uderzasz"  then value = 1
    elseif dmg == "raniac"  then value = 2
    elseif dmg == "ranisz" then value = 3
    elseif dmg == "poszarpana" then value = 4
    elseif dmg == "powaznie" then value = 5
    elseif dmg == "ciezko" then value = 6
    elseif dmg == "poteznie" then
        return scripts.gags:gag_prefix(scripts.gags.fin_prefix, target)
    end
    scripts.gags:gag(value, 6, target)
end

-- Lodowy lsniacy sztylet

function trigger_func_skrypty_ui_gags_ciosy_lodowy_lsniacy_sztylet_moje()
    local target = "moje_ciosy"
    local dmg = matches["damage"]
    local value = -1
        if dmg == "mija"  then value = 0
    elseif dmg == "jedynie nieznaczne" or dmg == "zmrozona" or dmg == "smuge"  then value = 1
    elseif dmg == "jedynie nieduze" or dmg == "szrame"  then value = 2
    elseif dmg == "znaczne" or dmg == "rozcina" then value = 3
    elseif dmg == "bolesne" or dmg == "grymas" then value = 4
    elseif dmg == "bardzo rozlegle" or dmg == "strumien" then value = 5
    elseif dmg == "potworne" or dmg == "szkarlatna" or dmg == "powazne" or dmg == "powazna rane" then value = 6
    elseif dmg == "blyskawicznie" then
        return scripts.gags:gag_prefix(scripts.gags.fin_prefix, target)
    end
    scripts.gags:gag(value, 6, target)
end

-- Masywny dlugi sztylet

function trigger_func_skrypty_ui_gags_ciosy_masywny_dlugi_sztylet_moje()
    local target = "moje_ciosy"
    local dmg = matches["damage"]
    local value = -1
        if dmg == "przecina" then value = 0
    elseif dmg == "cofa" then value = 1
    elseif dmg == "plytka"  then value = 2
    elseif dmg == "brzydka"  then value = 2
    elseif dmg == "" then value = 4
    elseif dmg == "dotkliwe" then value = 5
    elseif dmg == "" then value = 6
    elseif dmg == "wbijajac" then
        return scripts.gags:gag_prefix(scripts.gags.fin_prefix, target)
    end
    scripts.gags:gag(value, 6, target)
end

-- Polyskujacy zdobiony sztylet

function trigger_func_skrypty_ui_gags_ciosy_polyskujacy_zdobiony_sztylet_moje()
    local target = "moje_ciosy"
    local dmg = matches["damage"]
    local value = -1
        if dmg == "unik" or dmg == "nie siega" or dmg == "wyparowany" then value = 0
    elseif dmg == "ledwie zahaczajac" then value = 1
    elseif dmg == "nieznacznie raniac"  then value = 2
    elseif dmg == "dotkliwie lomoczac"  then value = 2
    elseif dmg == "bolesnie obijajac" then value = 4
    elseif dmg == "bardzo ciezko tlukac" then value = 5
    elseif dmg == "broczaca" then value = 6
    elseif dmg == "uderzasz" then
        return scripts.gags:gag_prefix(scripts.gags.fin_prefix, target)
    end
    scripts.gags:gag(value, 6, target)
end

-- Snieznobialy lsniacy sztylet

function trigger_func_skrypty_ui_gags_ciosy_nieznobialy_lsniacy_sztylet_moje()
    local target = "moje_ciosy"
    local dmg = matches["damage"]
    local value = -1
        if dmg == "nie udaje" or dmg == "zadnych" then value = 0
    elseif dmg == "niewielka" then value = 1
    elseif dmg == "powazna" then value = 2
    elseif dmg == "wbijajac" then value = 3
    elseif dmg == "idealne" then
        return scripts.gags:gag_prefix(scripts.gags.fin_prefix, target)
    end
    scripts.gags:gag(value, 5, target)
end

-- Stalowe smocze pazury

function trigger_func_skrypty_ui_gags_ciosy_stalowe_smocze_pazury_moje()
    local target = "moje_ciosy"
    local dmg = matches["damage"]
    local value = -1
        if dmg == "wyparowuje" then value = 0
    elseif dmg == "lekko" then value = 1
    elseif dmg == "celnie"  then value = 2
    elseif dmg == "bolesny" then value = 3
    elseif dmg == "paskudna" then value = 4
    elseif dmg == "tniesz" or dmg == "ciezko" then value = 5
    elseif dmg == "gleboko" then value = 6
    elseif dmg == "." then
        return scripts.gags:gag_prefix(scripts.gags.fin_prefix, target)
    end
    scripts.gags:gag(value, 6, target)
end

-- Szylkretowy falisty sztylet

function trigger_func_skrypty_ui_gags_ciosy_szylkretowy_falisty_sztylet_moje()
    local target = "moje_ciosy"
    local dmg = matches["damage"]
    local value = -1
    
        if dmg == "mija"  then value = 0
    elseif dmg == "nieznaczne"  then value = 1
    elseif dmg == "nieduze"  then value = 2
    elseif dmg == "znaczne" then value = 3
    elseif dmg == "bolesne" then value = 4
    elseif dmg == "powazne" then value = 5
    elseif dmg == "bardzo rozlegle" then value = 6
    elseif dmg == "potworne" then
        return scripts.gags:gag_prefix(scripts.gags.fin_prefix, target)
    end
    scripts.gags:gag(value, 6, target)
end

-- Tileanski matowy sztylet

function trigger_func_skrypty_ui_gags_ciosy_tileanski_matowy_sztylet_moje()
    local target = "moje_ciosy"
    local dmg = matches["damage"]
    local value = -1
    
        if dmg == ""  then value = 0
    elseif dmg == "plytka" then value = 1
    elseif dmg == "lekka"  then value = 2
    elseif dmg == "gleboka"  then value = 3
    elseif dmg == "brutalnie" then value = 4
    elseif dmg == "fontanna" then value = 5
    elseif dmg == "bardzo ciezko" then value = 6
    elseif dmg == "Wyrwaniu" then
        return scripts.gags:gag_prefix(scripts.gags.fin_prefix, target)
    end
    scripts.gags:gag(value, 6, target)
end

-- Tileanskie sprezynowe stiletto

function trigger_func_skrypty_ui_gags_ciosy_tileanskie_sprezynowe_stiletto_moje()
    local target = "moje_ciosy"
    local dmg = matches["damage"]
    local value = -1
        if dmg == "obrazen." then value = 1
    elseif dmg == "rany!"  then value = 2
    elseif dmg == "krew!"  then value = 3
    elseif dmg == "trzewiach!"  then value = 4
    elseif dmg == "przeciwnikowi!" then value = 5
    end
    scripts.gags:gag_spec("STILLETTO ", value, 5, target)
end

-- Zabkowany zakrzywiony sztylet

function trigger_func_skrypty_ui_gags_ciosy_zabkowany_zakrzywiony_sztylet()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = matches["target"] == "cie" and "innych_ciosy_we_mnie" or "innych_ciosy"
    end
    local dmg = matches["damage"]
    local value = -1
        if dmg == "szybsz" then value = 0
    elseif dmg == "delikatnie"  then value = 1
    elseif dmg == "poszarpana"  then value = 2
    elseif dmg == "raniac"  then value = 3
    elseif dmg == "gleboko" then value = 4
    elseif dmg == "krwawa" then value = 5
    elseif dmg == "mordercze" then value = 6
    end
    scripts.gags:gag(value, 6, target)
end
