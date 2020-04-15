function trigger_func_skrypty_ui_gags_color_color_zaslony_nieudane_nie_zaslaniasz_ty()
    selectCurrentLine()
    deleteLine()
    cecho("\n<" .. scripts.gag_colors["zaslony_nieudane"] .. ">[N ZASLANIASZ] " .. matches[2] .. "\n")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_zaslony_nieudane_nie_zaslania_kogos()
    selectCurrentLine()
    deleteLine()
    cecho("\n<" .. scripts.gag_colors["zaslony_nieudane"] .. ">[ N ZASLANIA ] " .. matches[2] .. "\n")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_zaslony_nieudane_nie_wycofanie_ty()
    selectCurrentLine()
    local str_replace = "[ NIE WYCOFU ] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["zaslony_nieudane"])
    resetFormat()
end

