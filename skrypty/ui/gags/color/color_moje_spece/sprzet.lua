
function trigger_func_skrypty_ui_gags_color_color_moje_spece_zbroje_blekitno_srebrna_trojkatna_tarcza()
    scripts.gags:gag_prefix("TARCZA SPEC", "moje_spece")
    ateam:may_setup_paralyzed_name(matches[2])
end

function trigger_func_skrypty_ui_gags_color_color_moje_spece_zbroje_lsniaca_plomienista_tarcza()
    scripts.gags:gag_prefix("TARCZA SPEC", "moje_spece")
end

function trigger_func_skrypty_ui_gags_color_color_moje_spece_zbroje_ciemnogranatowy_smukly_helm()
    ateam:may_setup_paralyzed_name(matches["target"])
    scripts.gags:gag_prefix("HELM SPEC", "moje_spece")
end

function trigger_func_skrypty_ui_gags_color_color_moje_spece_bron_truje()
    scripts.gags:gag_prefix("BRON TRUJE", "moje_spece")
end

function trigger_func_skrypty_ui_gags_color_color_moje_spece_bronie_gigantyczny_granitowy_mlot()
    scripts.gags:gag_prefix("GRA OGL", "moje_spece")
    ateam:may_setup_paralyzed_name(matches["target"])
end

function trigger_func_skrypty_ui_gags_color_color_moje_spece_bronie_jasniejacy_zdobiony_jatagan()
    scripts.gags:gag_prefix("JATAGAN OGL", "moje_spece")
    ateam:may_setup_paralyzed_name(matches["target"])
end
