function trigger_func_pulapka_brokilon()
    prefix("[ PULAPKA ]  ")
    selectCurrentLine()
    fg("orange_red")
    resetFormat()
    scripts.utils.bind_functional_call("przetnij rzemien",  "przetnij rzemien")
end

function trigger_func_strzaly()
    prefix("[ STRZALY ]  ")
    selectCurrentLine()
    fg("orange_red")
    resetFormat()
end

function trigger_func_rusalka()
    prefix("[ UROK ]  ")
    selectCurrentLine()
    fg("orange_red")
    resetFormat()
    scripts.messages:show("UROK RUSALKI", "orange_red")
    scripts.utils.bind_functional_call("/zz rusalke",  "/zz rusalke")
end

function trigger_func_rusalka2()
    prefix("[ UROK ]  ")
    selectCurrentLine()
    fg("orange_red")
    resetFormat()
    scripts.utils.bind_functional_call("/zz rusalke",  "/zz rusalke")
end