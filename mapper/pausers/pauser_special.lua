function trigger_func_mapper_pausers_pauser_special_pauser_on_tytul_notki()
    amap.possible_pauser = true
end

function trigger_func_mapper_pausers_pauser_special_pauser_off_notka()
    if amap.possible_pauser then
        amap:follow_mode(true)
        amap.pauser_effective = false
        enableKey("temp_bind-")
        enableKey("temp_bind=")
        raiseEvent("amapPauserStopped")
        amap.possible_pauser = false
    end
end

