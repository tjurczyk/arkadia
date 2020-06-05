function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_we_mnie_ktos_ledwo_muska_cie()
    selectCurrentLine()
    local str_replace = "[1/6] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["innych_ciosy_we_mnie"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_we_mnie_ktos_lekko_rani_cie()
    selectCurrentLine()
    local str_replace = "[2/6] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["innych_ciosy_we_mnie"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_we_mnie_ktos_rani_cie()
    local exempts = {
        "lekko",
        "powaznie",
        "ciezko",
        "paskudnie",
        "smiertelnie"
    }
    if table.contains(exempts, matches[2]) then
        return
    end

    selectCurrentLine()
    local str_replace = "[3/6] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["innych_ciosy_we_mnie"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_we_mnie_ktos_powaznie_rani_cie()
    selectCurrentLine()
    local str_replace = "[4/6] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["innych_ciosy_we_mnie"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_we_mnie_ktos_bardzo_ciezko_rani_cie()
    selectCurrentLine()
    local str_replace = "[5/6] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["innych_ciosy_we_mnie"])
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_we_mnie_ktos_masakruje_cie()
    selectCurrentLine()
    local str_replace = "[6/6] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg(scripts.gag_colors["innych_ciosy_we_mnie"])
    resetFormat()
end

