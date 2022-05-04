-- Foremny mlot

function trigger_func_skrypty_ui_gags_moje_ciosy_foremny_mlot(value)
    scripts.gags:gag(value, 6, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_innych_ciosy_foremny_mlot(value)
    local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 6, target)
end

-- Rezonujacy mlot

function trigger_func_skrypty_ui_gags_moje_ciosy_rezonujacy_mlot(value)
    scripts.gags:gag(value, 4, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_innych_ciosy_rezonujacy_mlot(value)
    local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 4, target)
end

function trigger_func_skrypty_ui_gags_moje_ciosy_rezonujacy_mlot_spec()
    scripts.gags:gag_prefix("MLOT SPEC", "moje_spece")
end

function trigger_func_skrypty_ui_gags_innych_ciosy_rezonujacy_mlot_spec()
    scripts.gags:gag_prefix("MLOT SPEC", "innych_spece")
end

-- Gryfi mlot

function trigger_func_skrypty_ui_gags_moje_ciosy_gryfi_mlot(value)
    scripts.gags:gag(value, 5, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_innych_ciosy_gryfi_mlot(value)
    local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 5, target)
end

-- Runiczny mlot 

function trigger_func_skrypty_ui_gags_moje_ciosy_runiczny_mlot(value)
    scripts.gags:gag(value, 6, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_innych_ciosy_runiczny_mlot(value)
    local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 6, target)
end

-- Adamantytowy mlot

function trigger_func_skrypty_ui_gags_moje_ciosy_adamantytowy_mlot(value)
    scripts.gags:gag(value, 6, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_innych_ciosy_adamantytowy_mlot(value)
    if value == 2 and string.match(line, "lekko") then
        return
    end

    local target = rex.match(getCurrentLine(), "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 6, target)
end
