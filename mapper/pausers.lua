function trigger_func_mapper_pausers_on_pausers()
    amap:mapper_off()
    amap.pauser_effective = true
    disableKey("temp_bind-")
    disableKey("temp_bind=")
    raiseEvent("amapPauserStarted")
end

function trigger_func_mapper_pausers_off_pausers()
    amap:follow_mode(true)
    amap.pauser_effective = false
    enableKey("temp_bind-")
    enableKey("temp_bind=")
    raiseEvent("amapPauserStopped")
end

function trigger_func_mapper_pausers_off_pausers2()
    amap:follow_mode(true)
    amap.pauser_effective = false
    enableKey("temp_bind-")
    enableKey("temp_bind=")
    raiseEvent("amapPauserStopped")
end

