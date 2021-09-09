function trigger_func_skrypty_ui_gags_color_color_npc_goblin(value)
    scripts.gags:gag(value, 6, "npc")
end

function trigger_func_skrypty_ui_gags_color_color_npc_ogluch()
    if matches[2] ~= "cie" then
        ateam:may_setup_paralyzed_name(matches[2])
    end

    scripts.gags:gag_prefix("OGLUCH", "npc")
end

function trigger_func_skrypty_ui_gags_color_color_npc_koniec_oglucha()
    ateam:may_end_paralyzed_name(matches[2])
end

