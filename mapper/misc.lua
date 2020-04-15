function trigger_func_mapper_misc_mountain_dir_down()
    amap.mountain_moving_dir = "down"
end

function trigger_func_mapper_misc_mountain_dir_up()
    amap.mountain_moving_dir = "up"
end

function trigger_func_mapper_misc_mountain_falling()
    if amap.mountain_moving_dir and amap.mountain_moving_dir == "up" then
        amap:move_backward()
        amap:terminate_walker()
    end

    amap:follow_mode()
    amap.pauser_effective = false
    raiseEvent("amapPauserStopped")
end

