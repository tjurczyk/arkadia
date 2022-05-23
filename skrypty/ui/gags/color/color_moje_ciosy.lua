function trigger_func_skrypty_ui_gags_color_moje_ciosy(value)
    if line:match("opalizujacego runicznego")  then
        return
    end

    if rex.match(line, "srebrzyst\\w+ kos\\w+ bojow\\w+") then
        return
    end

    selectString(matches[1], 1)
    setFgColor(45, 185, 45)
    resetFormat()

    scripts.gags:gag(value, 6, "moje_ciosy")
end

