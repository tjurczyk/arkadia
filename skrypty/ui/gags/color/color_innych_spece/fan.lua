function trigger_func_skrypty_ui_gags_color_color_innych_spece_fan_ktos_spec_0()
    selectCurrentLine()
    local str_replace = "[FAN 0/7] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["innych_spece"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_innych_spece_fan_ktos_spec_fin()
    selectCurrentLine()
    local str_replace = "[FAN FIN] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["innych_spece"])
    resetFormat()
end

