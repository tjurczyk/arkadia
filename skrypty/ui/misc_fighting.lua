function trigger_func_skrypty_ui_misc_fighting_atakuje_cie()
    selectCurrentLine()
    fg("red")
    selectString("atakuje cie", 1)
    replace("ATAKUJE CIE")
    resetFormat()
end

function trigger_func_skrypty_ui_misc_fighting_atakuje()
    if matches[2] == "cie" then
        return
    end

    selectString("atakuje", 1)
    replace("ATAKUJE")
    resetFormat()
end

function trigger_func_skrypty_ui_misc_fighting_uciekl_ci()
    selectCurrentLine()
    setFgColor(64, 128, 191)
    resetFormat()
end

function trigger_func_skrypty_ui_misc_fighting_ledwo_lekko()
    selectString(matches[3], 1)
    setFgColor(45, 185, 45)
    resetFormat()
end

function trigger_func_skrypty_ui_misc_fighting_ranisz_powaznie()
    selectString(matches[3], 1)
    setFgColor(45, 185, 45)
    resetFormat()
end

function trigger_func_skrypty_ui_misc_fighting_bciezko_masakrujesz()
    selectString(matches[3], 1)
    setFgColor(45, 185, 45)
    resetFormat()
end

function trigger_func_skrypty_ui_misc_fighting_ledwo_lekko_cie()
    selectString(matches[4], 1)
    setFgColor(255, 153, 51)
    resetFormat()
end

function trigger_func_skrypty_ui_misc_fighting_rani_powaga_cie()
    if matches[4] == "lekko" then
        return
    end

    if matches[4] == "powaznie" then
        selectString(matches[4], 1)
        setFgColor(255, 153, 51)
        resetFormat()
    end

    selectString(matches[5], 1)
    setFgColor(255, 153, 51)
    resetFormat()
end

function trigger_func_skrypty_ui_misc_fighting_bciezko_masakruje_ciebie()
    selectString(matches[5], 1)
    setFgColor(255, 153, 51)
    resetFormat()
end

function trigger_func_skrypty_ui_misc_fighting_wspiera()
    if matches[3] == "cie" then
        return
    end

    selectString("wspiera", 1)
    replace("WSPIERA")
    resetFormat()
end

function trigger_func_skrypty_ui_misc_fighting_wspiera_cie()
    selectString("wspiera cie", 1)
    replace("WSPIERA CIE")
    resetFormat()
end

