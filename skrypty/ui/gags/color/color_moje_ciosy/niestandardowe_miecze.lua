function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_jatagan_ledwo_muskasz()
    scripts.gags:gag(1, 6, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_jatagan_lekko_ranisz()
    scripts.gags:gag(2, 6, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_jatagan_ranisz()
    if matches[2] == "powaznie" or matches[2] == "ciezko" then return end
    scripts.gags:gag(3, 6, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_jatagan_powaznie_ranisz()
    scripts.gags:gag(4, 6, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_jatagan_bardzo_ciezko_ranisz()
    scripts.gags:gag(5, 6, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_color_color_moje_ciosy_jatagan_masakrujesz()
    scripts.gags:gag(6, 6, "moje_ciosy")
end

-- Espadon

function trigger_func_skrypty_ui_gags_moje_ciosy_espadon(value)
    scripts.gags:gag(value, 7, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_innych_ciosy_espadon(value)
    local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 7, target)
end

-- Kruczoczarny miecz

function trigger_func_skrypty_ui_gags_moje_ciosy_kruczoczarny_miecz(value)
    scripts.gags:gag(value, 5, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_innych_ciosy_kruczoczarny_miecz(value)
    local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 5, target)
end

-- Arlekiny

function trigger_func_skrypty_ui_gags_moje_ciosy_arlekiny(value)
    scripts.gags:gag(value, 6, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_innych_ciosy_arlekiny(value)
    local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 6, target)
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