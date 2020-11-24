function trigger_func_skrypty_ui_gags_color_color_npc_goblin1()
    scripts.gags:gag(0, 3, "npc")
end

function trigger_func_skrypty_ui_gags_color_color_npc_goblin2()
    scripts.gags:gag(1, 3, "npc")
end

function trigger_func_skrypty_ui_gags_color_color_npc_goblin3()
    scripts.gags:gag(2, 3, "npc")
end

function trigger_func_skrypty_ui_gags_color_color_npc_goblin4()
    scripts.gags:gag(3, 3, "npc")
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

