-- Jatagan

function trigger_func_skrypty_ui_gags_moje_ciosy_jatagan(value)
    scripts.gags:gag(value, 6, "moje_ciosy")
end

-- Espadon

function trigger_func_skrypty_ui_gags_ciosy_espadon(value)
    if scripts.gags:is_type("combat.avatar") then
        scripts.gags:gag(value, 7, "moje_ciosy")
    else
        local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
        scripts.gags:gag(value, 7, target)
    end
end

-- Kruczoczarny miecz

function trigger_func_skrypty_ui_gags_ciosy_kruczoczarny_miecz(value)
    if scripts.gags:is_type("combat.avatar") then
        scripts.gags:gag(value, 5, "moje_ciosy")
    else
        local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
        scripts.gags:gag(value, 5, target)
    end
end

-- Arlekiny

function trigger_func_skrypty_ui_gags_ciosy_arlekiny(value)
    if scripts.gags:is_type("combat.avatar") then
        scripts.gags:gag(value, 6, "moje_ciosy")
    else
        local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
        scripts.gags:gag(value, 6, target)
    end
end

-- Szczerba

function trigger_func_skrypty_ui_gags_ciosy_szczerba(value)
    if scripts.gags:is_type("combat.avatar") then
        scripts.gags:gag(value, 5, "moje_ciosy")
    else
        local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
        scripts.gags:gag(value, 5, target)
    end
end

function trigger_func_skrypty_ui_gags_spece_szczerba(target)
    scripts.gags:gag_prefix("MIE OGL", line:starts("Dzierzony") and "innych_spece" or "moje_spece")
    ateam:may_setup_paralyzed_name(target)
end