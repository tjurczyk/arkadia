function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_jatagan_ledwo_muskasz()
    selectCurrentLine()
    local str_replace = "[1/6] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["moje_ciosy"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_jatagan_lekko_ranisz()
    selectCurrentLine()
    local str_replace = "[2/6] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["moje_ciosy"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_jatagan_ranisz()
    if matches[2] == "powaznie" or matches[2] == "ciezko" then
        return
    end

    selectCurrentLine()
    local str_replace = "[3/6] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["moje_ciosy"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_jatagan_powaznie_ranisz()
    selectCurrentLine()
    local str_replace = "[4/6] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["moje_ciosy"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_jatagan_bardzo_ciezko_ranisz()
    selectCurrentLine()
    local str_replace = "[5/6] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["moje_ciosy"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_jatagan_masakrujesz()
    selectCurrentLine()
    local str_replace = "[6/6] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["moje_ciosy"])
    resetFormat()
end

