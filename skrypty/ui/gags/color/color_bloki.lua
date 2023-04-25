function trigger_func_skrypty_ui_gags_color_color_bloki_blokowanie_proba_ciebie()
    if scripts.gags:delete_line("bloki") then
        return
    end

    raiseEvent("tryingToBlock", matches[3])
    creplaceLine("<red>\n\n[    BLOK    ] " .. matches[3] .. " przymierza sie do odciecia ci drogi ucieczki.\n\n")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_bloki_blokuje_cie()
    if scripts.gags:delete_line("bloki") then
        return
    end

    raiseEvent("hasBlocked", matches[2])
    creplaceLine("<red>\n\n[    BLOK    ] " .. matches[2])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_bloki_zajmuje_pozycje()
    if scripts.gags:delete_line("bloki") then
        return
    end

    if matches[2] == "ci" then
        return
    end

    raiseEvent("playBeep")
    tempTimer(0.3, function () raiseEvent("playBeep") end)
    creplaceLine("<tomato>\n\n[    BLOK    ] " .. matches[1])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_bloki_zajmujesz_pozycje()
    if scripts.gags:delete_line("bloki") then
        return
    end

    creplaceLine("<sea_green>\n\n[    BLOK    ] " .. matches[2])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_bloki_blokuje_ci_droge()
    if scripts.gags:delete_line("bloki") then
        return
    end

    raiseEvent("playBeep")
    creplaceLine("<red>\n\n[    BLOK    ] <reset>" .. matches[1])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_bloki_blokuje_droge()
    if scripts.gags:delete_line("bloki") then
        return
    end

    if matches[2] == "ci" then
        return
    end

    creplaceLine("<tomato>\n\n[    BLOK    ] <reset>" .. matches[1])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_bloki_blokujesz_droge()
    if scripts.gags:delete_line("bloki") then
        return
    end

    selectCurrentLine()
    local str_replace = "[    BLOK    ] "
    prefix(str_replace)
    if selectString(str_replace, 1) > -1 then
        fg("sea_green")
    end
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_bloki_omija_nieskuteczny_blok()
    if scripts.gags:delete_line("bloki") then
        return
    end

    selectCurrentLine()
    local str_replace = "[    BLOK    ] "
    prefix(str_replace)
    if selectString(str_replace, 1) > -1 then
        fg("yellow")
    end
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_bloki_przestajesz_odcinac()
    if scripts.gags:delete_line("bloki") then
        return
    end

    selectCurrentLine()
    local str_replace = "[    BLOK    ] "
    prefix(str_replace)
    if selectString(str_replace, 1) > -1 then
        fg("sea_green")
    end
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_bloki_blokowanie_proba_kogos()
    if scripts.gags:delete_line("bloki") then
        return
    end

    if matches[4] == "ci" then
        return
    end

    raiseEvent("playBeep")
    tempTimer(0.3, function () raiseEvent("playBeep") end)
    creplaceLine("<tomato>\n\n[    BLOK    ] " .. matches[2])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_bloki_blokowanie_proba_ty()
    if scripts.gags:delete_line("bloki") then
        return
    end

    creplaceLine("<sea_green>\n\n[    BLOK    ] " .. matches[1])
    resetFormat()
end
