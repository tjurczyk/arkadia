function trigger_func_baccala_wave()
    if amap.pauser_effective then
        amap.pausers:off()
        amap_step_back_perform()
    end 
    amap:follow("down", false)
end