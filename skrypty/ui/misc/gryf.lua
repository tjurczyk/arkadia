function trigger_func_skrypty_ui_misc_gryf_ogluch()
    scripts.sounds:play_beep_sequence()
    creplaceLine("<red>\n\n[   OGLUCH   ] ----- JESTES OGLUSZONY -----\n\n")
    scripts.ui:info_action_update("OGLUSZONY")
    resetFormat()
    enableTrigger("powrot-z-oglucha-gryfa")
end

function trigger_func_skrypty_ui_misc_gryf_powrot_z_oglucha_gryfa()
    disableTrigger("powrot-z-oglucha-gryfa")
    scripts.utils.bind_functional(scripts.inv.weapons.wield)
    scripts.ui:info_action_update("DOBADZ")
    scripts.ui.info_action_bind = scripts.inv.weapons.wield
end

