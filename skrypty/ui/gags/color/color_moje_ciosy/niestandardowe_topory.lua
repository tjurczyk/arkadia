-- Obosieczny gwiezdny topor

function trigger_func_skrypty_ui_gags_ciosy_obosieczny_gwiezdny_topor()
    local target = "moje_ciosy"
    if matches["attacker"] then
        target = matches["target"] == "twoje cialo" and "innych_ciosy_we_mnie" or "innych_ciosy"
    end
    local dmg = matches["damage"]
    local value = -1
        if dmg == "tnie plytko" then value = 1
    elseif dmg == "tnie gladko" then value = 2
    elseif dmg == "tnie lekko" then value = 3
    elseif dmg == "tnie szeroko" then value = 4
    elseif dmg == "tnie gleboko" then value = 5
    elseif dmg == "niemal przecina w pol" then value = 6
    else end
    scripts.gags:gag(value, 6, target)
end
