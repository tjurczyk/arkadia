function trigger_func_skrypty_ui_gags_color_color_innych_spece_fan_ktos_spec_ktos_spec()
    local target = matches["target"] == "cie" and "innych_ciosy_we_mnie" or "innych_spece"
    local dmg = matches["damage"]
    local value = -1
        if dmg == "ledwo muskajac" then value = 1
    elseif dmg == "lekko raniac" then value = 2
    elseif dmg == "raniac" then value = 3
    elseif dmg == "powaznie raniac" then value = 4
    elseif dmg == "bardzo ciezko raniac" then value = 5
    elseif dmg == "masakrujac" then value = 6
    else end

    scripts.gags:gag_spec("FAN", value, 7, target)
end

