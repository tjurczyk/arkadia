function trigger_func_skrypty_ui_gags_color_color_bron_ktos_opuszcza_bron()
    scripts.gags:gag_prefix("bron", "bron")
end

function trigger_func_skrypty_ui_gags_color_color_bron_walczysz_bez_broni()
    raiseEvent("ateamFightingWithNoWeapon")
    
    if scripts.gags:delete_line("bron") then
        return
    end

    selectCurrentLine()
    local str_replace = "[bron] "
    prefix(str_replace)
    selectString(str_replace, 1)
    fg("tomato")
    resetFormat()
end

function trigger_func_skrypty_ui_gags_color_color_bron_ktos_dobywa_broni()
    scripts.gags:gag_prefix("bron", "bron")
end

