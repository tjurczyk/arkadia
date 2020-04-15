function trigger_func_skrypty_ui_gags_color_color_bron_ktos_opuszcza_bron()
    selectCurrentLine()
    local str_replace = "[bron] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["bron"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_bron_walczysz_bez_broni()
    selectCurrentLine()
    local str_replace = "[bron] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg("tomato")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_bron_ktos_dobywa_broni()
    selectCurrentLine()
    local str_replace = "[bron] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["bron"])
    resetFormat()
end

