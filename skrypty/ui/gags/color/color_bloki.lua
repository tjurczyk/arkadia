function trigger_func_skrypty_ui_gags_color_color_bloki_blokowanie_proba_ciebie()
    raiseEvent("playBeep")
    tempTimer(0.3, [[ raiseEvent("playBeep") ]])
    tempTimer(0.6, [[ raiseEvent("playBeep") ]])
    tempTimer(0.9, [[ raiseEvent("playBeep") ]])
    tempTimer(1.2, [[ raiseEvent("playBeep") ]])
    selectCurrentLine()
    deleteLine()
    cecho("<red>\n\n[    BLOK    ] " .. matches[3] .. " przymierza sie do odciecia ci drogi ucieczki.\n\n")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_bloki_blokuje_cie()
    selectCurrentLine()
    local str_replace = "[    BLOK    ] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg("red")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_bloki_zajmujesz_pozycje()
    selectCurrentLine()
    local str_replace = "[    BLOK    ] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg("sea_green")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_bloki_blokujesz_droge()
    selectCurrentLine()
    local str_replace = "[    BLOK    ] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg("sea_green")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_bloki_omija_nieskuteczny_blok()
    selectCurrentLine()
    local str_replace = "[    BLOK    ] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg("yellow")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_bloki_przestajesz_odcinac()
    selectCurrentLine()
    local str_replace = "[    BLOK    ] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg("sea_green")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_bloki_blokowanie_proba_kogos()
    if matches[4] == "ci" then
        return
    end

    raiseEvent("playBeep")
    tempTimer(0.3, [[ raiseEvent("playBeep") ]])
    selectCurrentLine()
    deleteLine()
    cecho("<tomato>\n\n[    BLOK    ] " .. matches[2])
    resetFormat()
end

