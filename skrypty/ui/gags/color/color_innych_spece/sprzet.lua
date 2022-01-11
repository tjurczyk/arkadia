
function trigger_func_skrypty_ui_gags_color_color_innych_spece_zbroje_blekitno_srebrna_trojkatna_tarcza()
    scripts.gags:gag_prefix("TARCZA SPEC", "innych_spece")
    ateam:may_setup_paralyzed_name(matches[2])
end

function trigger_func_skrypty_ui_gags_color_color_innych_spece_zbroje_lsniaca_plomienista_tarcza()
    scripts.gags:gag_prefix("TARCZA SPEC", "innych_spece")
end

function trigger_func_skrypty_ui_gags_color_color_innych_spece_zbroje_ciemnogranatowy_smukly_helm()
    scripts.gags:gag_prefix("HELM SPEC", "innych_spece")
end

function trigger_func_skrypty_ui_gags_color_color_innych_spece_bronie_ciernista_kobaltowa_halabarda()
    scripts.gags:gag_prefix("BRON SPEC", "innych_spece")
end

function trigger_func_szczerba(target)
    scripts.gags:gag_prefix("BRON SPEC", line:starts("Dzierzony") and "innych_spece" or "moje_spece")
    ateam:may_setup_paralyzed_name(target)
end