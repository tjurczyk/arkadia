function trigger_func_skrypty_ui_gags_color_color_moje_spece_bar_ja_spec()
    --
end

function trigger_func_skrypty_ui_gags_color_color_moje_spece_bar_ja_granit()
    selectCurrentLine()
    local str_replace = "[GRA OGL] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["moje_spece"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_moje_spece_bar_ja_fin()
    selectCurrentLine()
    local str_replace = "[JA FIN] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["moje_spece"])
    resetFormat()
end

