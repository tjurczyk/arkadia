function trigger_func_mapper_localizers_ships_buses_urbimo_wyspaslubow_urbimo_gps()
    if amap and amap.curr and amap.curr.area == "Wyspa Slubow" then
        amap:print_log("GPS: Urbimo", true)
        amap:set_position(5946, true)
    end
end

function trigger_func_mapper_localizers_ships_buses_urbimo_wyspaslubow_urbimo_noc_gps()
    if amap and amap.curr and amap.curr.area == "Wyspa Slubow" then
        amap:print_log("GPS: Urbimo", true)
        amap:set_position(5946, true)
    end
end

function trigger_func_mapper_localizers_ships_buses_urbimo_wyspaslubow_wyspa_gps()
    if amap and amap.curr and amap.curr.area == "Urbimo" then
        amap:print_log("GPS: Wyspa Slubow", true)
        amap:set_position(11154, true)
    end
end


function trigger_func_mapper_localizers_ships_buses_urbimo_wyspaslubow_gps_urbimo()
    amap:print_log("GPS: Urbimo", true)
    amap:set_position(5946, true)
end

function trigger_func_mapper_localizers_ships_buses_urbimo_wyspaslubow_gps_wyspaslubow()
    amap:print_log("GPS: Wyspa Slubow", true)
    amap:set_position(11154, true)
end
