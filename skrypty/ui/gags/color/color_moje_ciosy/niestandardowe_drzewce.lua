-- Ognisty trojzab

function trigger_func_skrypty_ui_gags_ciosy_ognisty_trojzab(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 6, target)
end

-- Srebrzysta kosa

function trigger_func_skrypty_ui_gags_ciosy_kosa(value)
    if line:match("ykorzystujac dogodny moment") then
        return
    end
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 7, target)
end

-- Adamantytowa partyzana

function trigger_func_skrypty_ui_gags_ciosy_partyzana(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 7, target)
end

-- Kobaltowa halabarda

function trigger_func_skrypty_ui_gags_ciosy_kobaltowa(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 6, target)
end

function trigger_func_skrypty_ui_gags_kobaltowa_spec(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 3, target)
    magic_prefix("-MANA")
end

-- Laska druchii

function trigger_func_skrypty_ui_gags_ciosy_dluga_ciemna_laska()
    local target = "moje_ciosy"
    if matches["attacker"] and matches["attacker"] ~= "" then
        target = matches["target"] == "" and "innych_ciosy_we_mnie" or "innych_ciosy"
    end

    local dmg = matches["damage"]
    local value = -1
        if dmg == "nieznaczne" then value = 1
    elseif dmg == "lekkie" then value = 2
    elseif dmg == "znaczne" then value = 3
    elseif dmg == "powazne" then value = 4
    elseif dmg == "potworne" then value = 5
    elseif dmg == "straszliwe" then value = 6

    end
    scripts.gags:gag(value, 6, target)
end

-- Czarna smukla glewia

function trigger_func_skrypty_ui_gags_ciosy_czarna_smukla_glewia()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = matches["target"] == "cie" and "innych_ciosy_we_mnie" or "innych_ciosy"
    end

    local dmg = matches["damage"]
    local value = -1
        if dmg == "nieznacznie" then value = 1
    elseif dmg == "powierzchowna rane" then value = 2
    elseif dmg == "celnym cieciem" then value = 3
    elseif dmg == "powaznie" then value = 4
    elseif dmg == "bardzo ciezko" then value = 5
    elseif dmg == "rozdziera cialo" then value = 6
    end
    scripts.gags:gag(value, 6, target)
end
