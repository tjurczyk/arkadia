function trigger_func_skrypty_ui_misc_gryf_ogluch()
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
    enableTrigger("powrot-z-oglucha-gryfa")
end

function trigger_func_skrypty_ui_misc_gryf_powrot_z_oglucha_gryfa()
    disableTrigger("powrot-z-oglucha-gryfa")
    scripts.utils.bind_functional("dobadz wszystkich broni")
    scripts.ui:info_action_update("DOBADZ")
    scripts.ui.info_action_bind = "dobadz wszystkich broni"
end

