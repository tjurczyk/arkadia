function trigger_func_skrypty_ui_gags_color_color_rozkazy_rozkaz_kogos_zaslony()
    if scripts.gags:delete_line("rozkazy") then
        return
    end

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
    if scripts.gags:delete_line("rozkazy") then
        return
    end

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
    local str_replace = "<sea_green>[ ROZKAZ WYK ] <".. scripts.gag_colors["zaslony_udane"] .. ">[ ZASLANIA ] " .. matches[1]
    creplaceLine(str_replace)
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_rozkazy_rozkaz_atak_wykonanie()
    if scripts.gags:delete_line("rozkazy") then
        return
    end

    selectCurrentLine()
    local str_replace = "[ ROZKAZ WYK ] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg("sea_green")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_rozkazy_rozkaz_kogos_zablokowac()
    if scripts.gags:delete_line("rozkazy") then
        return
    end
    
    selectCurrentLine()
    deleteLine()
    cecho("<salmon>\n\n[ ROZKAZ BLO ] " .. matches[2] .. matches[3] .. ".\n\n")
    resetFormat()
end

