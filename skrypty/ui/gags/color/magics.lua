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

function trigger_func_skrypty_ui_gags_ciosy_bronie_z_kamieniami(value)
    if scripts.gags:is_type("combat.avatar") then
        scripts.gags:gag(value, 6, "moje_ciosy")
    else
        local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
        scripts.gags:gag(value, 6, target)
    end
end

function trigger_func_skrypty_ui_gags_ciosy_wprawiane_kamienie(value)
    if scripts.gags:is_type("combat.avatar") then
        scripts.gags:gag_spec("KAMIEN", value, 4, "moje_spece")
    else
        local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_spece"
        scripts.gags:gag_spec("KAMIEN", value, 4, target)
    end
end

-- Upiorne bronie

function trigger_func_skrypty_ui_gags_ciosy_upiorne_bronie(value)
    if scripts.gags:is_type("combat.avatar") then
        scripts.gags:gag(value, 6, "moje_ciosy")
    else
        local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
        scripts.gags:gag(value, 6, target)
    end
end

-- Jasniejace bronie

function trigger_func_skrypty_ui_gags_ciosy_jasniejace_bronie(value)
    if scripts.gags:is_type("combat.avatar") then
        scripts.gags:gag(value, 7, "moje_ciosy")
    else
        local target = rex.match(line, "\\b(?:ciebie|cie|ci)\\b") and "innych_ciosy_we_mnie" or "innych_ciosy"
        scripts.gags:gag(value, 7, target)
    end
end

-- Finishery

function trigger_func_skrypty_ui_gags_moje_ciosy_bron_fin()
    scripts.gags:gag_prefix("FIN", "moje_ciosy")
end

function trigger_func_skrypty_ui_gags_innych_ciosy_bron_fin()
    scripts.gags:gag_prefix("FIN", "innych_ciosy")
end

function trigger_func_skrypty_ui_gags_ciosy_bron_fin()
    if scripts.gags:is_type("combat.avatar") then
        scripts.gags:gag_prefix("FIN", "moje_ciosy")
    else
        scripts.gags:gag_prefix("FIN", "innych_ciosy")
    end

end