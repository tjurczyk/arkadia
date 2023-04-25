function trigger_func_skrypty_ui_gags_color_color_ogluchy_ogluch()
    if scripts.gags:delete_line("ogluchy") then
        return
    end

    raiseEvent("stunStart")
    selectCurrentLine()
    prefix("<red>[OGLUCH] ", cecho)    
    cecho("<red>\n\n[   OGLUCH   ] ----- JESTES OGLUSZONY -----\n\n")
    scripts.ui:info_action_update("OGLUSZONY")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_ogluchy_powrot_z_oglucha()
    if scripts.gags:delete_line("ogluchy") then
        return
    end

    raiseEvent("stunEnd")
    creplaceLine("<LawnGreen>\n\n[   OGLUCH   ] ----- KONIEC OGLUCHA -----\n\n")
    resetFormat()
    scripts.ui:info_action_update("")
end

function trigger_func_skrypty_ui_gags_color_color_ogluchy_ogluch_golem_ktos()
    scripts.gags:gag_prefix("OGLUCH", "npc")
end

