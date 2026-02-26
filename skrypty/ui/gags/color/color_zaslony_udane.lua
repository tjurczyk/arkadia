function trigger_func_skrypty_ui_gags_color_color_zaslony_udane_zaslaniasz_ty()
    raiseEvent("maneuverAttempted")
    if scripts.gags:delete_line("zaslony_udane") then
        return
    end

    creplaceLine("<" .. scripts.gag_colors["zaslony_udane"] .. ">\n\n[ ZASLANIASZ ] " .. matches[2] .. "\n\n")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_zaslony_udane_zaslania_kogos()
    if matches[1]:find("pomiedzy toba") then
        raiseEvent("maneuverAttempted")
    end
    if scripts.gags:delete_line("zaslony_udane") then
        return
    end

    creplaceLine("<" .. scripts.gag_colors["zaslony_udane"] .. ">\n\n[  ZASLANIA  ] " .. matches[2] .. "\n\n")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_zaslony_udane_wycofanie_za_ciebie()
    raiseEvent("maneuverAttempted")
    if scripts.gags:delete_line("zaslony_udane") then
        return
    end

    scripts.gags:gag_prefix(" WYC ZA CIE ", "zaslony_udane")
end

function trigger_func_skrypty_ui_gags_color_color_zaslony_udane_wycofanie_sie_ty()
    raiseEvent("maneuverAttempted")
    if scripts.gags:delete_line("zaslony_udane") then
        return
    end

    scripts.gags:gag_prefix(" WYCOFUJESZ ", "zaslony_udane")
end

function trigger_func_skrypty_ui_gags_color_color_zaslony_udane_wycofanie_kogos()
    if scripts.gags:delete_line("zaslony_udane") then
        return
    end

    scripts.gags:gag_prefix(" WYC ", "zaslony_udane")
end
