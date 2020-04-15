function trigger_func_skrypty_ui_misc_lilith_oddaje_bron_ja()
    cecho("\n\n\n<tomato>[    BRON    ] " .. matches[2] .. " -> BRON WYRWANA, WEZ BRON\n\n\n")
end

function trigger_func_skrypty_ui_misc_lilith_oddaje_bron()
    cecho("\n\n\n<tomato>[    BRON    ] " .. matches[2] .. " -> BRON WYRWANA, NIECH WEZMIE BRON\n\n\n")
end

function trigger_func_skrypty_ui_misc_lilith_wyrywa_bron()
    cecho("\n\n\n<tomato>[    BRON    ] BRON WYRWANA, SZUKAC W LABIRYNCIE\n\n\n")
    raiseEvent("playBeep")
end

