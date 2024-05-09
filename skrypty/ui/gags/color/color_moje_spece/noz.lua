function trigger_func_skrypty_ui_gags_color_color_moje_spece_noz_ja_spec()
    local dmg = matches["damage"]
    local value = -1
        if dmg == "mija" or dmg == "unika" or dmg == "nieskoordynowany" then value = 0
    elseif dmg == "nieznaczne" or dmg == "drasniecie" then value = 1
    elseif dmg == "wbijasz" or dmg == "bolesny" or dmg=="celnie" then value = 2
    elseif dmg == "bolesna" or dmg == "krwawa" or dmg=="znaczne" then value = 3
    elseif dmg == "krwawiaca" or dmg == "ranisz" or dmg=="powazne" then value = 4
    elseif dmg == "zaglebiasz" or dmg == "tryska krew" then value = 5
    elseif dmg == "przypadasz" or dmg == "rozlegle" or dmg == "bardzo powazne" or dmg == "bardzo ciezko" then value = 6
    elseif dmg == "osuwa" or dmg == "zachodzac" or dmg == "doskakujesz" or dmg == "masakruje" then
        scripts.gags:gag_own_spec(scripts.gags.fin_prefix)
        return
    end
  --scripts.gags:gag(value, 8, "moje_ciosy")
  scripts.gags:gag_own_spec(value, 6)
end
