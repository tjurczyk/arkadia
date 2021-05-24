function trigger_func_skrypty_ui_gags_moje_ciosy_opal_spec(value)
    scripts.gags:gag(value, 5, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_moje_ciosy_opal(value)
    scripts.gags:gag(value, 7, "moje_ciosy")
end


function trigger_func_skrypty_ui_gags_opal_innych(value)
    local target = rex.match(getCurrentLine(), "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 7, target)
end

function trigger_func_skrypty_ui_gags_opal_spec_innych(value)
    local target = rex.match(getCurrentLine(), "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 5, target)
end