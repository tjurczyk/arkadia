function trigger_func_skrypty_ui_gags_color_color_zaslony_nieudane_nie_zaslaniasz_ty()
    if scripts.gags:delete_line("zaslony_nieudane") then
        return
    end

    creplaceLine("\n<" .. scripts.gag_colors["zaslony_nieudane"] .. ">[N ZASLANIASZ] " .. matches[2] .. "\n")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_zaslony_nieudane_nie_zaslania_kogos()
    if scripts.gags:delete_line("zaslony_nieudane") then
        return
    end
    
    creplaceLine("\n<" .. scripts.gag_colors["zaslony_nieudane"] .. ">[ N ZASLANIA ] " .. matches[2] .. "\n")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_zaslony_nieudane_nie_wycofanie_ty()
    if scripts.gags:delete_line("zaslony_nieudane") then
        return
    end
    
    selectCurrentLine()
    local str_replace = "[ NIE WYCOFU ] "
    prefix(str_replace)
    if selectString(str_replace, 1) > -1 then
        fg(scripts.gag_colors["zaslony_nieudane"])
    end
    resetFormat()
end

