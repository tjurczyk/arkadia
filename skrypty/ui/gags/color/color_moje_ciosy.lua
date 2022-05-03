function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_ja_ledwo_muska()
    scripts.gags:gag(1, 6, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_ja_lekko_rani()
    if not rex.match(getCurrentLine(), "opalizujacego runicznego") then
        scripts.gags:gag(2, 6, "moje_ciosy")
    end
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_ja_rani()
    scripts.gags:gag(3, 6, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_ja_powaznie_rani()
    scripts.gags:gag(4, 6, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_ja_bardzo_ciezko_rani()
    scripts.gags:gag(5, 6, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_ja_masakruje()
    if not string.match(line, "srebrzysta kosa bojowa") then
        scripts.gags:gag(6, 6, "moje_ciosy")
    end
end

