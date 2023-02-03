function trigger_func_skrypty_ui_gags_color_color_npc(value)
    scripts.gags:gag(value, 6, "npc_spece")
end

function trigger_func_skrypty_ui_gags_color_color_npc_ogluch()
    if matches[2] ~= "cie" then
        ateam:may_setup_paralyzed_name(matches[2])
    end

    scripts.gags:gag_prefix("OGLUCH", "npc_spece")
end

function trigger_func_skrypty_ui_gags_color_color_npc_koniec_oglucha()
    ateam:may_end_paralyzed_name(matches[2])
end

function trigger_func_skrypty_ui_gags_color_color_npc_goblin()
    local dmg = matches["damage"]
    local value = -1
    if dmg == "kaleczy"  then value = 1
    elseif dmg == "rozkrwawia"  then value = 2
    elseif dmg == "rani"  then value = 3
    elseif dmg == "gleboko rani"  then value = 4
    elseif dmg == "prawieze rozrabuje"  then value = 5
    elseif dmg == "wprost rozrabuje"  then value = 6
    end
    trigger_func_skrypty_ui_gags_color_color_npc(value)
end
