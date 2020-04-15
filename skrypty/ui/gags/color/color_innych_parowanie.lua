function trigger_func_skrypty_ui_gags_color_color_innych_parowanie_ktos_paruje()
    selectCurrentLine()
    local str_replace = "[par] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["innych_parowanie"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_innych_parowanie_ktos_zbroja_paruje()
    if matches[2] == "cie" then
        return
    end

    selectCurrentLine()
    local str_replace = "[par] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["innych_parowanie"])
    resetFormat()
end

