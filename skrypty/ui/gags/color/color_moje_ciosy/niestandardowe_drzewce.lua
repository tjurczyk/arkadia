-- Ognisty trojzab

function trigger_func_skrypty_ui_gags_ciosy_ognisty_trojzab(value)
    if scripts.gags:is_type("combat.avatar") then
        scripts.gags:gag(value, 5, "moje_ciosy")
    else
        local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
        scripts.gags:gag(value, 5, target)
    end
end

-- Srebrzysta kosa

function trigger_func_skrypty_ui_gags_ciosy_kosa(value)
    if scripts.gags:is_type("combat.avatar") then
        scripts.gags:gag(value, 7, "moje_ciosy")
    else
        local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
        scripts.gags:gag(value, 7, target)
    end
end

-- Adamantytowa partyzana

function trigger_func_skrypty_ui_gags_ciosy_partyzana(value)
    if scripts.gags:is_type("combat.avatar") then
        scripts.gags:gag(value, 7, "moje_ciosy")
    else
        local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
        scripts.gags:gag(value, 7, target)
    end
end

-- Kobaltowa halabarda

function trigger_func_skrypty_ui_gags_ciosy_kobaltowa(value)
    if scripts.gags:is_type("combat.avatar") then
        scripts.gags:gag(value, 6, "moje_ciosy")
    else
        local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
        scripts.gags:gag(value, 6, target)
    end
end

function trigger_func_skrypty_ui_gags_kobaltowa_spec(value)
    if scripts.gags:is_type("combat.avatar") then
        scripts.gags:gag(value, 3, "moje_ciosy")
    else
        local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
        scripts.gags:gag(value, 3, target)
    end

    magic_prefix("-MANA")
end
