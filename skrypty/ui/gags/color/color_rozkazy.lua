function trigger_func_skrypty_ui_gags_color_color_rozkazy_rozkaz_kogos_zaslony()
    selectCurrentLine()
    deleteLine()
    if matches[3] == "ciebie" or matches[3] == "cie" then
        local uppered = string.upper(matches[3])
        cecho("<sea_green>\n\n[ ROZKAZ DEF ] " .. matches[2] .. uppered .. ".\n\n")
    else
        cecho("<sea_green>\n\n[ ROZKAZ DEF ] " .. matches[2] .. matches[3] .. ".\n\n")
    end
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_rozkazy_rozkaz_kogos_zaatakowac()
    selectCurrentLine()
    deleteLine()
    if matches[3] == "ciebie" or matches[3] == "cie" then
        local uppered = string.upper(matches[3])
        cecho("<salmon>\n\n[ ROZKAZ ATT ] " .. matches[2] .. uppered .. ".\n\n")
    else
        cecho("<salmon>\n\n[ ROZKAZ ATT ] " .. matches[2] .. matches[3] .. ".\n\n")
    end
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_rozkazy_rozkaz_zaslona_wykonanie()
    selectCurrentLine()
    local str_replace = "[ ROZKAZ WYK ] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg("sea_green")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_rozkazy_rozkaz_kogos_zablokowac()
    selectCurrentLine()
    deleteLine()
    cecho("<salmon>\n\n[ ROZKAZ BLO ] " .. matches[2] .. matches[3] .. ".\n\n")
    resetFormat()
end

