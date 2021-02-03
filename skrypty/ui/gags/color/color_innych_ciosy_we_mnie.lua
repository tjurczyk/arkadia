function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_we_mnie_ktos_ledwo_muska_cie()
    scripts.gags:gag(1, 6, "innych_ciosy_we_mnie")
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_we_mnie_ktos_lekko_rani_cie()
    scripts.gags:gag(2, 6, "innych_ciosy_we_mnie")
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_we_mnie_ktos_rani_cie()
    local exempts = {"lekko", "powaznie", "ciezko", "paskudnie", "smiertelnie"}
    if table.contains(exempts, matches[2]) then return end

    scripts.gags:gag(3, 6, "innych_ciosy_we_mnie")
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_we_mnie_ktos_powaznie_rani_cie()
    scripts.gags:gag(4, 6, "innych_ciosy_we_mnie")
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_we_mnie_ktos_bardzo_ciezko_rani_cie()
    scripts.gags:gag(5, 6, "innych_ciosy_we_mnie")
end

function trigger_func_skrypty_ui_gags_color_color_innych_ciosy_we_mnie_ktos_masakruje_cie()
    scripts.gags:gag(6, 6, "innych_ciosy_we_mnie")
end

