function trigger_func_skrypty_ui_misc_nie_ma_kierunku()
    selectString(matches[2], 1)
    fg("tan")
    resetFormat()
end

function trigger_func_skrypty_ui_misc_jestes_zbyt_zmeczony()
    selectCurrentLine()
    fg("tan")
    resetFormat()
end

function trigger_func_skrypty_ui_misc_tablica_ogloszeniowa()
    selectCurrentLine()
    fg("cornsilk")
    resetFormat()
end

function trigger_func_skrypty_ui_misc_klapa_campogrotta()
    raiseEvent("playBeep")
    selectCurrentLine()
    fg("tomato")
    resetFormat()
end

function trigger_func_skrypty_ui_misc_zniszczona_bron(owner)
    creplaceLine("<tomato>\n\n[  SPRZET  ] " .. matches[1] .. "\n\n")
    resetFormat()

    if not owner then
        raiseEvent("playBeep")
        scripts.ui:info_action_update("ZNI. BRON")
        scripts.utils.bind_functional("odloz zlamana bron")
        scripts.ui.info_action_bind = "odloz zlamana bron"
    end
end

function trigger_func_skrypty_ui_misc_zniszczony_sprzet(owner)
    creplaceLine("<tomato>\n\n[  SPRZET  ] " .. matches[1] .. "\n\n")
    resetFormat()

    if not owner then
        raiseEvent("playBeep")
        scripts.ui:info_action_update("ZNI. ZBROJA")
        scripts.utils.bind_functional("odloz zniszczona zbroje")
        scripts.ui.info_action_bind = "odloz zniszczona zbroje"
    end
end

function trigger_func_skrypty_ui_misc_wyverna_trucizna_off()
    creplaceLine("<LawnGreen>\n\n[  ZDROWIE  ] <grey>" .. line .. "\n\n")
    scripts.ui:info_action_update("")
end

function trigger_func_skrypty_ui_misc_trucizna_on()
    creplaceLine("<tomato>\n\n[  ZDROWIE  ] <grey>" .. line .. "\n\n")
    scripts.ui:info_action_update("ZATRUTY")
end

function trigger_func_skrypty_ui_misc_daje_ci()
    if matches[3] == "nowy zapal do walki." then
        return
    end

    selectCurrentLine()
    fg("turquoise")
    resetFormat()
end

function trigger_func_skrypty_ui_misc_przybywaja_count()
    selectCurrentLine()
    local count = string:count_people(matches[2])
    prefix("[" .. tostring(count).. "] ")
    resetFormat()
end

function trigger_func_skrypty_ui_misc_przebywa_count()
    selectCurrentLine()
    prefix("[1] ")
    resetFormat()
end

function trigger_func_skrypty_ui_misc_przybywaja_highlight()
    selectString(matches[2], 1)
    setFgColor(204, 179, 255)
    resetFormat()
end

function trigger_func_skrypty_ui_misc_podazasz_highlight()
    selectString(matches[2], 1)
    setFgColor(170, 128, 255)
    resetFormat()
    selectCurrentLine()
    prefix("[2] ")
    resetFormat()
end

function trigger_func_skrypty_ui_misc_wraz_z_podazasz()
    local size = string:split_people(matches[2])
    selectString(matches[3], 1)
    setFgColor(170, 128, 255)
    resetFormat()
    prefix("[" .. tostring(#size + 2) .. "] ")
    resetFormat()
end

function trigger_func_skrypty_ui_misc_blokuje_ci_droge()
    selectString(matches[2], 1)
    fg("tan")
    resetFormat()
end

function trigger_func_skrypty_ui_misc_podaza_na()
    selectString(matches[2], 1)
    setFgColor(170, 128, 255)
    resetFormat()
    selectCurrentLine()
    prefix("[1] ")
    resetFormat()
end

function trigger_func_skrypty_ui_misc_podazaja_na()
    local count = string:count_people(matches[2])
    selectString(matches[3], 1)
    setFgColor(170, 128, 255)
    resetFormat()
    selectCurrentLine()
    prefix("[" .. count .. "] ")
    resetFormat()
end

function trigger_func_skrypty_ui_misc_wskazuje_dol_trop()
    if ateam.team_names[matches[2]] then
        scripts.utils.bind_functional("trop")
    end
end

function trigger_func_skrypty_ui_misc_gory_wyjscia_zejscia()
    selectCurrentLine()
    fg("LawnGreen")
    resetFormat()
end

function trigger_func_skrypty_ui_misc_zywiolak_wykopuje_cie()
    selectCurrentLine()
    local str_replace = "\n\n Wykopanie przez zywiolaka!\n\n"
    prefix(str_replace)
    selectString(str_replace, 1)
    fg("red")
    resetFormat()
end

function trigger_func_skrypty_ui_misc_zywiolak_wykopuje_kogos()
    selectCurrentLine()
    local str_replace = "\n\n " .. matches[2] .. " wykopany przez zywiolaka!\n\n"
    prefix(str_replace)
    selectString(str_replace, 1)
    fg("yellow")
    resetFormat()
end

function trigger_func_skrypty_ui_misc_powoz_maribor_kierunek()
    local cursor = selectString("stojacy powoz", 1)
    if cursor then
        moveCursor(cursor + 13, getLineNumber())
        insertText(" (Bodrog)")
    end
end

function trigger_func_skrypty_ui_misc_woz_maribor_kierunek()
    local cursor = selectString("stojacy woz", 1)
    if cursor then
        moveCursor(cursor + 11, getLineNumber())
        insertText(" (Grabowa Buchta)")
    end
end

function trigger_func_skrypty_ui_misc_zmeczenie()
    local level = matches[2]
    local color = 'green'

    if level == 'bardzo zmeczony' or level == 'bardzo zmeczona' or level == 'nieco wyczerpany' or level == 'nieco wyczerpana' or level == 'wyczerpany' or level == 'wyczerpana' then
        color = 'ansi_light_yellow'
    elseif level == 'bardzo wyczerpany' or level == 'bardzo wyczerpana' or level == 'wycienczony' or level == 'wycienczona' or level == 'calkowicie wycienczony' or level == 'calkowicie wycienczona' then
        color = 'ansi_light_red'
    end

    selectCurrentLine()
    selectString(level, 1)
    fg(color)

    resetFormat()
end

