function trigger_func_skrypty_ui_gags_color_moje_ciosy(value)
    local ignore_list = {
        "opalizujacego runicznego",
        "czarnoblekitnego pulsujacego morgensterna",
	"czarnego smuklego topora",
    }

    for _, v in pairs(ignore_list) do
        if line:match(v) then
            return
        end
    end

    if rex.match(line, "srebrzyst\\w+ kos\\w+ bojow\\w+") then
        return
    end
    selectString(matches[1], 1)
    setFgColor(45, 185, 45)
    resetFormat()

    scripts.gags:gag(value, 6, "moje_ciosy")
end

