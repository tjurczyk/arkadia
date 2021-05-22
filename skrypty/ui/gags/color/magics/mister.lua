function trigger_func_skrypty_ui_gags_moje_ciosy_misterny(value)
    scripts.gags:gag(value, 6, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_misterny_innych(value)
    local matches = rex.match(matches[1], "\b(?:ciebie|cie|ci)\b")
    display(matches)
    scripts.gags:gag(value, 6, "innych_ciosy_we_mnie")
end