function trigger_func_skrypty_ui_gags_color_color_ogluchy_ogluch()
    raiseEvent("playBeep")
    tempTimer(0.3, [[ raiseEvent("playBeep") ]])
    tempTimer(0.6, [[ raiseEvent("playBeep") ]])
    tempTimer(0.9, [[ raiseEvent("playBeep") ]])
    tempTimer(1.2, [[ raiseEvent("playBeep") ]])
    selectCurrentLine()
    deleteLine()
    cecho("<red>\n\n[   OGLUCH   ] ----- JESTES OGLUSZONY -----\n\n")
    scripts.ui:info_action_update("OGLUSZONY")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_ogluchy_powrot_z_oglucha()
    raiseEvent("playBeep")
    selectCurrentLine()
    deleteLine()
    cecho("<LawnGreen>\n\n[   OGLUCH   ] ----- KONIEC OGLUCHA -----\n\n")
    resetFormat()
    scripts.ui:info_action_update("")
end

function trigger_func_skrypty_ui_gags_color_color_ogluchy_ogluch_golem_ktos()
    selectCurrentLine()
    local str_replace = "[OGLUCH] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["npc"])
    resetFormat()
end

