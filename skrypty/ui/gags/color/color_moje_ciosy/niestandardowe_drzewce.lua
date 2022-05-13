-- Ognisty trojzab

function trigger_func_skrypty_ui_gags_moje_ciosy_ognisty_trojzab(value)
    scripts.gags:gag(value, 5, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_innych_ciosy_ognisty_trojzab(value)
    local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 5, target)
end

-- Srebrzysta kosa

function trigger_func_skrypty_ui_gags_moje_ciosy_kosa(value)
    scripts.gags:gag(value, 7, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_innych_ciosy_kosa(value)

    if value == 2 and string.match(line, "lekko") then
        return
    end

    local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 7, target)
end

-- Adamantytowa partyzana

function trigger_func_skrypty_ui_gags_moje_ciosy_partyzana(value)
    scripts.gags:gag(value, 7, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_innych_ciosy_partyzana(value)
    local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 7, target)
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
