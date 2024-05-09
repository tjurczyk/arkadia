-- Foremny mlot

function trigger_func_skrypty_ui_gags_ciosy_foremny_mlot(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 6, target)
end

-- Rezonujacy mlot

function trigger_func_skrypty_ui_gags_ciosy_rezonujacy_mlot(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 4, target)
end

function trigger_func_skrypty_ui_gags_ciosy_rezonujacy_mlot_spec()
    if scripts.gags:is_type("combat.avatar") then
        scripts.gags:gag_prefix("MLOT SPEC", "moje_spece")
    else
        scripts.gags:gag_prefix("MLOT SPEC", "innych_spece")
    end
end

-- Gryfi mlot

function trigger_func_skrypty_ui_gags_ciosy_gryfi_mlot(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 5, target)
end

-- Runiczny mlot

function trigger_func_skrypty_ui_gags_ciosy_runiczny_mlot(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 6, target)
end

-- Adamantytowy mlot

function trigger_func_skrypty_ui_gags_ciosy_adamantytowy_mlot(value)
    if line:match("ostrzegajac luke w obronie przeciwnika") then
        return
    end
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 6, target)
end

-- Czarny smukly mlot

function trigger_func_skrypty_ui_gags_ciosy_czarny_smukly_mlot()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = matches["target"] == "cie" and "innych_ciosy_we_mnie" or "innych_ciosy"
    end

    local dmg = matches["damage"]
    local value = -1
    if dmg == "zahaczyc" or dmg == "zahacza" then value = 1
    elseif dmg == "krwawy slad" then value = 2
    elseif dmg == "miazdzac" then value = 3
    elseif dmg == "powaznie" then value = 4
    elseif dmg == "bardzo ciezkie" then value = 5
    elseif dmg == "wewnetrznych obrazeniach" then value = 6
    end
    scripts.gags:gag(value, 6, target)
end

-- zielonkawy bretonski mlot

function trigger_func_skrypty_ui_gags_ciosy_zielonkawy_bretonski_mlot()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = matches["target"] == "cie" and "innych_ciosy_we_mnie" or "innych_ciosy"
    end

    local dmg = matches["damage"]
    local value = -1
    if dmg == "mija" or dmg == "obok" then value = 0
    elseif dmg == "niewielkie" then value = 1
    elseif dmg == "raniac" then value = 2
    elseif dmg == "tlucze" then value = 3
    elseif dmg == "miazdzy" then value = 4
    elseif dmg == "miazdzac" then value = 5
    end
    scripts.gags:gag(value, 6, target)
end
