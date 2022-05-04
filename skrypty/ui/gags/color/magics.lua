-- Misterny

function trigger_func_skrypty_ui_gags_moje_ciosy_misterny(value)
    scripts.gags:gag(value, 6, "moje_ciosy")
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


function trigger_func_skrypty_ui_gags_opal_innych(value)
    local target = rex.match(getCurrentLine(), "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 7, target)
end

function trigger_func_skrypty_ui_gags_opal_spec_innych(value)
    local target = rex.match(getCurrentLine(), "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 5, target)
end

-- Bronie z wprawianymi kamieniami:
-- wulkaniczny mlot, jadeitowy palasz, misterny harpun, kosciany topor, kosciane berlo, wulkaniczny kindzal

function trigger_func_skrypty_ui_gags_moje_ciosy_bronie_z_kamieniami(value)
    scripts.gags:gag(value, 6, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_innych_ciosy_bronie_z_kamieniami(value)
    local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 6, target)
end

function trigger_func_skrypty_ui_gags_moje_ciosy_wprawiane_kamienie(value)
    scripts.gags:gag(value, 4, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_innych_ciosy_wprawiane_kamienie(value)
    local target = rex.match(getCurrentLine(), "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 4, target)
end

-- Upiorne bronie

function trigger_func_skrypty_ui_gags_moje_ciosy_upiorne_bronie(value)
    scripts.gags:gag(value, 6, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_innych_ciosy_upiorne_bronie(value)
    local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 6, target)
end

-- Jasniejace bronie

function trigger_func_skrypty_ui_gags_moje_ciosy_jasniejace_bronie(value)
    scripts.gags:gag(value, 7, "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_innych_ciosy_jasniejace_bronie(value)
    local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
    scripts.gags:gag(value, 7, target)
end

-- Finishery

function trigger_func_skrypty_ui_gags_moje_ciosy_bron_fin()
    scripts.gags:gag_prefix("FIN", "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_innych_ciosy_bron_fin()
    scripts.gags:gag_prefix("FIN", "innych_ciosy")
end