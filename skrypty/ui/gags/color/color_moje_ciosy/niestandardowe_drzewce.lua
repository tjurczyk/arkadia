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

function trigger_func_skrypty_ui_gags_moje_ciosy_kobaltowa(value)
    scripts.gags:gag(value, 5, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_innych_ciosy_kobaltowa(value)
    local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 5, target)
end