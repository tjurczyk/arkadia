function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_zbroje_baron_tarcza()
    selectCurrentLine()
    local str_replace = "[HERB SPEC] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["innych_ciosy"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_zbroje_lsniaca_tarcza()
    selectCurrentLine()
    local str_replace = "[LSN SPEC] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["innych_ciosy"])
    resetFormat()
end

