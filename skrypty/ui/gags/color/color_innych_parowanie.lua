function trigger_func_skrypty_ui_gags_color_color_innych_parowanie_ktos_paruje()
    scripts.gags:gag_prefix("par", "innych_parowanie")
end

function trigger_func_skrypty_ui_gags_color_color_innych_parowanie_ktos_tarcza_paruje()
    scripts.gags:gag_prefix("tar", "innych_parowanie")
end

function trigger_func_skrypty_ui_gags_color_color_innych_parowanie_ktos_zbroja_paruje()
    if matches[2] == "cie" then
        return
    end

    scripts.gags:gag_prefix("zbr", "innych_parowanie")
end

