function trigger_func_skrypty_ui_gags_color_color_cele_cel_obrony_ktos()
    if scripts.gags:delete_line("cele") then
        return
    end

    selectCurrentLine()
    deleteLine()
    if matches[3] == "ciebie" then
        cecho("<sea_green>\n\n[  CEL DEF   ] " .. matches[2] .. "CIEBIE jako CEL OBRONY.\n\n")
    else
        cecho("<sea_green>\n\n[  CEL DEF   ] " .. matches[2] .. matches[3] .. " jako CEL OBRONY.\n\n")
    end
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_cele_cel_ataku_ktos()
    if scripts.gags:delete_line("cele") then
        return
    end
    
    selectCurrentLine()
    deleteLine()

    if matches[3] == "ciebie" then
        local uppered = string.upper(matches[3])
        cecho("<salmon>\n\n[  CEL ATT   ] " .. matches[2] .. uppered .. " jako CEL ATAKU.\n\n")
    else
        cecho("<salmon>\n\n[  CEL ATT   ] " .. matches[2] .. matches[3] .. " jako CEL ATAKU.\n\n")
    end
    resetFormat()
end

