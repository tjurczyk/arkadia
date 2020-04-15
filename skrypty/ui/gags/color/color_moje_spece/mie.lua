function trigger_func_skrypty_ui_gags_color_color_moje_spece_mie_ja_spec_end()
    selectCurrentLine()
    local str_replace = "[JA FIN] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["moje_spece"])
    resetFormat()
end

