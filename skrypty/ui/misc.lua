function trigger_func_skrypty_ui_misc_nie_ma_kierunku()
    selectString(matches[2], 1)
    fg("tan")
    resetFormat()
end

function trigger_func_skrypty_ui_misc_jestes_zbyt_zmeczony()
    selectString(matches[2], 1)
    fg("tan")
    resetFormat()
end

function trigger_func_skrypty_ui_misc_tablica_ogloszeniowa()
    selectString(matches[2], 1)
    fg("cornsilk")
    resetFormat()
end

function trigger_func_skrypty_ui_misc_klapa_campogrotta()
    raiseEvent("playBeep")
    selectString(matches[2], 1)
    fg("tomato")
    resetFormat()
end

function trigger_func_skrypty_ui_misc_zniszczona_bron()
    selectCurrentLine()
    deleteLine()
    cecho("<tomato>\n\n[  SPRZET  ] " .. matches[2] .. "\n\n")
    resetFormat()

    if not string.match(matches[2], "dzierzon") then
        raiseEvent("playBeep")
        scripts.ui:info_action_update("ZNI. BRON")
        scripts.utils.bind_functional("odloz zlamana bron")
        scripts.ui.info_action_bind = "odloz zlamana bron"
    end
end

function trigger_func_skrypty_ui_misc_zniszczony_sprzet()
    creplaceLine("<tomato>\n\n[  SPRZET  ] " .. matches[1] .. "\n\n")
    resetFormat()

    local by_space = string.split(matches[2], " ")
    local third_to_last_letter = string.sub(by_space[#by_space - 2], 1, 1)
    local third_to_last_uppered = string.upper(third_to_last_letter)

    if third_to_last_letter ~= third_to_last_uppered then
        raiseEvent("playBeep")
        scripts.ui:info_action_update("ZNI. ZBROJA")
        scripts.utils.bind_functional("odloz zniszczona zbroje")
        scripts.ui.info_action_bind = "odloz zniszczona zbroje"
    end
end

function trigger_func_skrypty_ui_misc_wyverna_trucizna_off()
    selectCurrentLine()
    deleteLine()
    cecho("<LawnGreen>\n\n[  ZDROWIE  ] <grey>" .. matches[2] .. "\n\n")
    scripts.ui:info_action_update("")
end

function trigger_func_skrypty_ui_misc_wyverna_trucizna_on()
    selectCurrentLine()
    deleteLine()
    cecho("<tomato>\n\n[  ZDROWIE  ] <grey>" .. matches[2] .. "\n\n")
    scripts.ui:info_action_update("ZATRUTY")
end

function trigger_func_skrypty_ui_misc_ghoul_trucizna()
    selectCurrentLine()
    deleteLine()
    cecho("<tomato>\n\n[  ZDROWIE  ] <grey>" .. matches[1] .. "\n\n")
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
    selectString(matches[2], 1)
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
    selectCurrentLine()
    local str_replace = " (Bodrog)"
    suffix(str_replace)
    resetFormat()
end

function trigger_func_skrypty_ui_misc_woz_maribor_kierunek()
    selectCurrentLine()
    local str_replace = " (Grabowa Buchta)"
    suffix(str_replace)
    resetFormat()
end

