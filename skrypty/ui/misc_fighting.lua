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

