-- Misterny

function trigger_func_skrypty_ui_gags_moje_ciosy_misterny(value)
    scripts.gags:gag(value, 6, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_moje_ciosy_misterny_fin()
    scripts.gags:gag_prefix(scripts.gags.fin_prefix, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_misterny_innych(value)
    local target = rex.match(getCurrentLine(), "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 6, target)
end

-- Opal

function trigger_func_skrypty_ui_gags_moje_ciosy_opal_spec(value)
    scripts.gags:gag(value, 5, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_moje_ciosy_opal(value)
    scripts.gags:gag(value, 7, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_moje_ciosy_opal_fin(value)
    scripts.gags:gag_prefix(scripts.gags.fin_prefix, "moje_ciosy")
end


function trigger_func_skrypty_ui_gags_opal_innych(value)
    local target = matches["target"]
    target = (target == "ciebie" or target == "cie" or target == "ci") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 7, target)
end

function trigger_func_skrypty_ui_gags_opal_spec_innych(value)
    local target = matches["target"]
    target = (target == "ciebie" or target == "cie" or target == "ci")  and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 5, target)
end

-- archaiczny topor

function trigger_func_skrypty_ui_gags_ciosy_archaiczny_topor(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 6, target)
end

-- Bronie z wprawianymi kamieniami:
-- wulkaniczny mlot, jadeitowy palasz, misterny harpun, kosciany topor, kosciane berlo, wulkaniczny kindzal

function trigger_func_skrypty_ui_gags_ciosy_bronie_z_kamieniami(value)
    if line:match("brak broni u przeciwnika") then
        return
    end
    if line:match("ykorzystujac dogodny moment wyprowadza") then
        return
    end

    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 6, target)
end

function trigger_func_skrypty_ui_gags_ciosy_wprawiane_kamienie(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag_spec("KAMIEN", value, 4, target)
end

-- Upiorne bronie

function trigger_func_skrypty_ui_gags_ciosy_upiorne_bronie(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 6, target)
end

-- Jasniejace bronie

function trigger_func_skrypty_ui_gags_ciosy_jasniejace_bronie(value)
    local target = scripts.gags:who_hits()
    scripts.gags:gag(value, 7, target)
end

-- czarnoblekitny pulsujacy morgenstern

function trigger_func_skrypty_ui_gags_ciosy_czarnoblekitny_pulsujacy_morgenstern(value)
    scripts.gags:attacker_target(value)
end

function trigger_func_skrypty_ui_gags_ciosy_czarnoblekitny_pulsujacy_morgenstern_fin()
    scripts.gags:attacker_target_fin()
end

-- Finishery

function trigger_func_skrypty_ui_gags_moje_ciosy_bron_fin()
    scripts.gags:gag_prefix(scripts.gags.fin_prefix, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_innych_ciosy_bron_fin()
    scripts.gags:gag_prefix(scripts.gags.fin_prefix, "innych_ciosy")
end

function trigger_func_skrypty_ui_gags_ciosy_bron_fin()
    if scripts.gags:is_type("combat.avatar") then
        scripts.gags:gag_prefix(scripts.gags.fin_prefix, "moje_ciosy")
    else
        scripts.gags:gag_prefix(scripts.gags.fin_prefix, "innych_ciosy")
    end

end