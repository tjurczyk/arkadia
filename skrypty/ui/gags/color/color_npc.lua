function trigger_func_skrypty_ui_gags_color_color_npc_goblin1()
    selectCurrentLine()
    local str_replace = "[0/3] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["npc"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_npc_goblin2()
    selectCurrentLine()
    local str_replace = "[1/3] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["npc"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_npc_goblin3()
    selectCurrentLine()
    local str_replace = "[2/3] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["npc"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_npc_goblin4()
    selectCurrentLine()
    local str_replace = "[3/3] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["npc"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_npc_ogluch()
    selectCurrentLine()
    local str_replace = "[OGLUCH] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["npc"])
    resetFormat()

    if matches[2] ~= "cie" then
        ateam:may_setup_paralyzed_name(matches[2])
    end
end

function trigger_func_skrypty_ui_gags_color_color_npc_koniec_oglucha()
    ateam:may_end_paralyzed_name(matches[2])
end

