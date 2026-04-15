function trigger_func_skrypty_ui_gags_color_color_ogluchy_ogluch()
    if scripts.gags:delete_line("ogluchy") then
        return
    end

    raiseEvent("stunStart")
    raiseEvent("playSound", "stun")
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

function trigger_func_skrypty_ui_gags_color_color_ogluchy_ogluch_demon_skrzydla_ktos()
    local names_str = matches[2]
    names_str = names_str:gsub(" i ", ", ")
    for name in names_str:gmatch("[^,]+") do
        name = name:match("^%s*(.-)%s*$")
        if name and name ~= "" then
            ateam:may_setup_paralyzed_name(name)
        end
    end
    scripts.gags:gag_prefix("OGLUCH", "npc_spece")
end

