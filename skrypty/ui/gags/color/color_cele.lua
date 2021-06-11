function trigger_func_skrypty_ui_gags_color_color_cele_cel_obrony_ktos()
    if scripts.gags:delete_line("cele") then
        return
    end

    if matches[3] == "ciebie" then
        creplaceLine("<sea_green>\n\n[  CEL DEF   ] " .. matches[2] .. "CIEBIE jako CEL OBRONY.\n\n")
    else
        creplaceLine("<sea_green>\n\n[  CEL DEF   ] " .. matches[2] .. matches[3] .. " jako CEL OBRONY.\n\n")
    end
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_cele_cel_ataku_ktos()
    if scripts.gags:delete_line("cele") then
        return
    end
    
    if matches[3] == "ciebie" then
        local uppered = string.upper(matches[3])
        creplaceLine("<salmon>\n\n[  CEL ATT   ] " .. matches[2] .. uppered .. " jako CEL ATAKU.\n\n")
    else
        creplaceLine("<salmon>\n\n[  CEL ATT   ] " .. matches[2] .. matches[3] .. " jako CEL ATAKU.\n\n")
    end
    resetFormat()
end

