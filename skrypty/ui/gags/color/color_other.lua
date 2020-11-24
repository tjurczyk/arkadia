function trigger_func_skrypty_ui_gags_color_color_other_zabiles_color()
    selectCurrentLine()

    local counter = 1
    if misc.counter.killed_amount["JA"] then
        counter = misc.counter.killed_amount["JA"]
    end
    local counter_str = "<tomato> (" .. tostring(counter) .. " / " .. tostring(misc.counter.all_kills) .. ")"

    deleteLine()
    cecho("\n\n<tomato>[  ZABILES  ] <grey>" .. matches[2] .. counter_str .. "\n\n")
    scripts.inv.collect:killed_action()
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_other_zabil_color()
    selectCurrentLine()
    local counter_str = nil

    if ateam.team_names[matches[3]] then
        local counter = 1
        if misc.counter.killed_amount[matches[3]] then
            counter = misc.counter.killed_amount[matches[3]]
        end
        counter_str = " (" .. tostring(counter) .. " / " .. tostring(misc.counter.all_kills) .. ")"
    end

    deleteLine()
    if counter_str then
        cecho("\n\n<tomato>[   ZABIL   ] <grey>" .. matches[2] .. counter_str .. "\n\n")
    else
        cecho("\n\n<tomato>[   ZABIL   ] <grey>" .. matches[2] .. "\n\n")
    end
    scripts.inv.collect:team_killed_action(matches[3])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_other_mozesz_dobywac()
    raiseEvent("playBeep")
    raiseEvent("canWieldAfterKnockOff")
    selectCurrentLine()
    deleteLine()
    cecho("<green>\n\n[    BRON    ]<cornsilk> Mozesz dobyc broni klawiszem ']'\n\n")
    resetFormat()
    scripts.utils.bind_functional("dobadz wszystkich broni")
    scripts.ui:info_action_update("DOBADZ")
    scripts.ui.info_action_bind = "dobadz wszystkich broni"
end

function trigger_func_skrypty_ui_gags_color_color_other_wytracenie_tobie()
    raiseEvent("playBeep")
    raiseEvent("weaponKnockedOff")
    selectCurrentLine()
    deleteLine()
    cecho("\n\n<tomato>[    BRON    ] " .. matches[2] .. "\n\n")
    resetFormat()
    scripts.ui:info_action_update("WYTRACENIE")
end

function trigger_func_skrypty_ui_gags_color_color_other_przelamanie()
    deleteLine()
    local team_break = ateam.team_names[matches[3]] or ateam.team_names[string.lower(matches[3])]
    local color = team_break and "green" or "red"
    cecho("<".. color ..">\n\n[ KTOS LAMIE ] " .. matches[2] .. "\n\n")
    ateam:may_setup_broken_defense(matches[4])
    resetFormat()

    if team_break then
        cecho("<" .. scripts.ui:get_bind_color_backward_compatible() .. ">  [" .. scripts.keybind:keybind_tostring("attack_target") .. "<" .. scripts.ui:get_bind_color_backward_compatible() .. ">] zabij cel ataku\n")
    end
end

function trigger_func_skrypty_ui_gags_color_color_other_przelamanie_ty()
    deleteLine()
    cecho("<green>\n\n[ TY LAMIESZ ] " .. matches[2] .. "\n\n")
    ateam:may_setup_broken_defense(matches[3])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_other_nie_przelamanie_ty()
    deleteLine()
    cecho("<tomato>\n\n[ NIE LAMIESZ ] " .. matches[2] .. "\n\n")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_other_nie_przelamanie()
    deleteLine()
    cecho("<tomato>\n\n[ NIE LAMIE  ] " .. matches[2] .. "\n\n")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_other_nekro_tilea()
    raiseEvent("playBeep")
    selectCurrentLine()
    deleteLine()
    cecho("<green>\n\n[    BRON    ]<cornsilk> Wez bron i dobadz jej\n\n")
    resetFormat()
    scripts.utils.bind_functional("dobadz wszystkich broni")
    scripts.ui:info_action_update("WEZ BRON/DOBADZ")
    scripts.ui.info_action_bind = "dobadz wszystkich broni"
end

function trigger_func_team_leadership()
    fg("DarkGoldenrod")
    prefix("[   DRUZYNA   ]  ")
    echo("\n")
    resetFormat()
end
