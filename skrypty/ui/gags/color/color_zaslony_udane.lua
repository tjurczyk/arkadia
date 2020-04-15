function trigger_func_skrypty_ui_gags_color_color_zaslony_udane_zaslaniasz_ty()
    selectCurrentLine()
    deleteLine()
    cecho("<" .. scripts.gag_colors["zaslony_udane"] .. ">\n\n[ ZASLANIASZ ] " .. matches[2] .. "\n\n")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_zaslony_udane_zaslania_kogos()
    deleteLine()
    cecho("<" .. scripts.gag_colors["zaslony_udane"] .. ">\n\n[  ZASLANIA  ] " .. matches[2] .. "\n\n")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_zaslony_udane_wycofanie_za_ciebie()
    selectCurrentLine()
    local str_replace = "[ WYC ZA CIE ] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["zaslony_udane"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_zaslony_udane_wycofanie_sie_ty()
    selectCurrentLine()
    local str_replace = "[ WYCOFUJESZ ] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["zaslony_udane"])
    resetFormat()
end

