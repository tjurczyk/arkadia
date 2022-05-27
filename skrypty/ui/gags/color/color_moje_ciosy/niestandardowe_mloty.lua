-- Foremny mlot

function trigger_func_skrypty_ui_gags_ciosy_foremny_mlot(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 6, target)
end

-- Rezonujacy mlot

function trigger_func_skrypty_ui_gags_ciosy_rezonujacy_mlot(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 4, target)
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
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 5, target)
end

-- Runiczny mlot

function trigger_func_skrypty_ui_gags_ciosy_runiczny_mlot(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 6, target)
end

-- Adamantytowy mlot

function trigger_func_skrypty_ui_gags_ciosy_adamantytowy_mlot(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 6, target)
end

