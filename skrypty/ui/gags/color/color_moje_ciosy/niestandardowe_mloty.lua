-- Foremny mlot

function trigger_func_skrypty_ui_gags_ciosy_foremny_mlot(value)
    if scripts.gags:is_type("combat.avatar") then
        scripts.gags:gag(value, 6, "moje_ciosy")
    else
        local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
        scripts.gags:gag(value, 6, target)
    end
end

-- Rezonujacy mlot

function trigger_func_skrypty_ui_gags_ciosy_rezonujacy_mlot(value)
    if scripts.gags:is_type("combat.avatar") then
        scripts.gags:gag(value, 4, "moje_ciosy")
    else
        local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
        scripts.gags:gag(value, 4, target)
    end
end

function trigger_func_skrypty_ui_gags_ciosy_rezonujacy_mlot_spec()
    if scripts.gags:is_type("combat.avatar") then
        scripts.gags:gag_prefix("MLOT SPEC", "moje_spece")
    else
        scripts.gags:gag_prefix("MLOT SPEC", "innych_spece")
    end
end

-- Gryfi mlot

function trigger_func_skrypty_ui_gags_ciosy_gryfi_mlot(value)
    if scripts.gags:is_type("combat.avatar") then
        scripts.gags:gag(value, 5, "moje_ciosy")
    else
        local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
        scripts.gags:gag(value, 5, target)
    end
end

-- Runiczny mlot

function trigger_func_skrypty_ui_gags_ciosy_runiczny_mlot(value)
    if scripts.gags:is_type("combat.avatar") then
        scripts.gags:gag(value, 6, "moje_ciosy")
    else
        local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
        scripts.gags:gag(value, 6, target)
    end
end

-- Adamantytowy mlot

function trigger_func_skrypty_ui_gags_ciosy_adamantytowy_mlot(value)
    if scripts.gags:is_type("combat.avatar") then
        scripts.gags:gag(value, 6, "moje_ciosy")
    else
        local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
        scripts.gags:gag(value, 6, target)
    end
end

