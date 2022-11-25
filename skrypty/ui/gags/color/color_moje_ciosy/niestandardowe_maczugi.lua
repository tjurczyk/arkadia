function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_dwusegmentowa()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = matches["target"] == "cie" and "innych_ciosy_we_mnie" or "innych_ciosy"
    end

    local dmg = matches["damage"]
    local value = -1
        if dmg == "unika" then value = 0
    elseif dmg == "nie zadajac" or dmg == "ledwie muskajac" then value = 1
    elseif dmg == "broczaca krwia rane" or dmg == "nieduze obrazenia" then value = 2
    elseif dmg == "krwawo wgryzaja" or dmg == "widoczne obrazenia" then value = 3
    elseif dmg == "raniac" then value = 4
    elseif dmg == "paskudnie kaleczac" then value = 5
    elseif dmg == "krwawo rozrywa" or dmg == "potwornie rani" then value = 6
    elseif dmg == "masakrujac" then value = 7
    end
    scripts.gags:gag(value, 7, target)
end


function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_krysztalowy_swietlisty_korbacz_0()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = matches["target"] == "cie" and "innych_ciosy_we_mnie" or "innych_ciosy"
    end
    scripts.gags:gag(0, 7, target)
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_krysztalowy_swietlisty_korbacz()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = matches["target"] == "cie" and "innych_ciosy_we_mnie" or "innych_ciosy"
    end
    local dmg = matches["damage"]
    local value = -1
        if dmg == "ledwie zahaczajac"      then value = 1
    elseif dmg == "nieznacznie tlukac"     then value = 2
    elseif dmg == "bolesnie obijajac"      then value = 3
    elseif dmg == "dotkliwie raniac"       then value = 4
    elseif dmg == "bardzo ciezko lomoczac" then value = 5
    end
    scripts.gags:gag(value, 7, target)
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_krysztalowy_swietlisty_korbacz_6()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = matches["target"] == "cie" and "innych_ciosy_we_mnie" or "innych_ciosy"
    end
    scripts.gags:gag(6, 7, target)
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_krysztalowy_swietlisty_korbacz_fin()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = matches["target"] == "cie" and "innych_ciosy_we_mnie" or "innych_ciosy"
    end
    scripts.gags:gag_prefix("FIN", target)
end


function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_lodowata_dluga_maczuga()
    local dmg = matches["damage"]
    local value = -1
        if dmg == "ledwo muskajac" then value = 1
    elseif dmg == "pozostawiajac lekkiego, zmrozonego siniaka" then value = 2
    elseif dmg == "pozostawiajac sporego, fioletowego siniaka" then value = 3
    elseif dmg == "lekko raniac" then value = 4
    elseif dmg == "ciezko raniac" then value = 4
    elseif dmg == "raniac" then value = 5
    elseif dmg == "mocno obijajac cialo" then value = 6
    elseif dmg == "pozostawiajac paskudnie wygladajaca rane" then value = 7
    elseif dmg == "niemalze zabijajac" then value = 8
    elseif dmg == "masakrujac" or dmg == "masakrujac przeciwnika i zakanczajac ta walke" then value = 9
    else end
    scripts.gags:gag(value, 9, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_lodowata_dluga_maczuga_fin()
    scripts.gags:gag_prefix("FIN", "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_runiczny_korbacz_0() scripts.gags:gag(0, 7, "moje_ciosy") end
function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_runiczny_korbacz_1() scripts.gags:gag(1, 7, "moje_ciosy") end
function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_runiczny_korbacz_2() scripts.gags:gag(2, 7, "moje_ciosy") end
function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_runiczny_korbacz_3() scripts.gags:gag(3, 7, "moje_ciosy") end
function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_runiczny_korbacz_4() scripts.gags:gag(4, 7, "moje_ciosy") end
function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_runiczny_korbacz_5() scripts.gags:gag(5, 7, "moje_ciosy") end
function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_runiczny_korbacz_6() scripts.gags:gag(6, 7, "moje_ciosy") end
function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_runiczny_korbacz_fin() scripts.gags:gag_prefix("JA FIN", "moje_ciosy") end
function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_runiczny_korbacz_spec() scripts.gags:gag_prefix("BRON SPEC", "moje_spece") end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_pulsujacy_morgenstern_0() scripts.gags:gag(0, 6, "moje_ciosy") end
function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_pulsujacy_morgenstern_1() scripts.gags:gag(1, 6, "moje_ciosy") end
function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_pulsujacy_morgenstern_2() scripts.gags:gag(2, 6, "moje_ciosy") end
function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_pulsujacy_morgenstern_3() scripts.gags:gag(3, 6, "moje_ciosy") end
function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_pulsujacy_morgenstern_4() scripts.gags:gag(4, 6, "moje_ciosy") end
function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_pulsujacy_morgenstern_5() scripts.gags:gag(5, 6, "moje_ciosy") end
function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_pulsujacy_morgenstern_6() scripts.gags:gag(6, 6, "moje_ciosy") end
function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_pulsujacy_morgenstern_fin() scripts.gags:gag_prefix("FIN", "moje_ciosy") end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_iskrzaca_zdobiona_bulawa()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = (matches["target"] == nil or matches["target"] == "cie") and "innych_ciosy_we_mnie" or "innych_ciosy"
    end

    local dmg = matches["damage"]
    local value = -1
        if dmg == "lekko" then value = 1
    elseif dmg == "rani" then value = 2
    elseif dmg == "raniac" then value = 3
    elseif dmg == "powaznie" then value = 4
    elseif dmg == "razi" then value = 5
    elseif dmg == "razac" then value = 6
    else end
    scripts.gags:gag(value, 6, target)
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_iskrzaca_zdobiona_bulawa_fin()
    scripts.gags:gag_prefix("FIN", "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_starozytne_kosciane_berlo()
    local dmg = matches["damage"]
    local value = -1
        if dmg == "ledwie zahaczajac" then value = 1
    elseif dmg == "bolesnie obijajac" then value = 2
    elseif dmg == "nieznacznie tlukac" then value = 3
    elseif dmg == "dotkliwie raniac" then value = 4
    elseif dmg == "bardzo ciezko lomoczac" then value = 5
    elseif dmg == "masakrujac" then value = 6
    else cecho("<red>" .. dmg) end
    scripts.gags:gag(value, 7, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_starozytne_kosciane_berlo_fin()
    scripts.gags:gag_prefix("FIN", "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_starozytne_kosciane_berlo_spec()
    local dmg = matches["damage"]
    local value = -1
        if dmg == "znaczne" then value = 1
    elseif dmg == "lekkie" then value = 2
    elseif dmg == "powazne" then value = 3
    elseif dmg == "potworne" then value = 4
    else end
    scripts.gags:gag(value, 5, "moje_ciosy")
end

-- Czarny smukly morgenstern

function trigger_func_skrypty_ui_gags_ciosy_czarny_smukly_morg()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = matches["target"] == "cie" and "innych_ciosy_we_mnie" or "innych_ciosy"
    end

    local dmg = matches["damage"]
    local value = -1
        if dmg == "krotki wypad" then value = 1
    elseif dmg == "Lekko kaleczysz" or dmg == "lekko kaleczy" then value = 2
    elseif dmg == "raniac" then value = 3
    elseif dmg == "powazne" then value = 4
    elseif dmg == "ciezko" then value = 5
    elseif dmg == "krwawa miazge" then value = 6
    end
    scripts.gags:gag(value, 6, target)
end