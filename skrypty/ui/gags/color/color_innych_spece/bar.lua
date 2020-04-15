function trigger_func_skrypty_ui_gags_color_color_innych_spece_bar_ktos_granit()
    selectCurrentLine()
    local str_replace = "[GRA OGL] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["innych_spece"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_innych_spece_bar_ktos_fin()
    selectCurrentLine()
    local str_replace = "[BAR FIN] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["innych_spece"])
    resetFormat()
end

