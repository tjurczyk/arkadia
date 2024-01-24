function trigger_func_skrypty_ui_gags_color_color_innych_spece_leg_ktos_spec()
    local target = scripts.gags:who_hits_attacker_target()
    local dmg = matches["damage"]
    local value = -1
        if dmg == "Cios" or dmg == "W" or dmg == "Na" or dmg == "Niestety" then value = 0
    elseif dmg == "Slaby" then value = 1
    elseif dmg == "Niezbyt" then value = 2
    elseif dmg == "Silny" then value = 3
    elseif dmg == "Potezny" then value = 4
    elseif dmg == "Mocny" then value = 5
    elseif dmg == "Bezlitosny" then value = 6
    elseif dmg == "Morderczy" then value = 6
    elseif dmg == "tnie" then value = 6
    elseif dmg == "Widzisz" then
        scripts.gags:gag_prefix("LEG "..scripts.gags.fin_prefix, target)
        return
    end

    scripts.gags:gag_spec("LEG", value, 6, target)
end
