function trigger_func_mapper_localizers_ships_buses_ships_novigrad_blaviken_daevon_gps_novigrad()
    amap:print_log("GPS: Novigrad", true)
    amap:set_position(2223, true)
end

function trigger_func_mapper_localizers_ships_buses_ships_novigrad_blaviken_daevon_gps_daevon()
    amap:print_log("GPS: Daevon", true)
    amap:set_position(11690, true)
end

function trigger_func_mapper_localizers_ships_buses_ships_novigrad_blaviken_daevon_gps_blaviken()
    if amap and amap.curr and amap.curr.area == "Novigrad" then
        amap:print_log("GPS: Blaviken", true)
        amap:set_position(4061, true)
    elseif amap and amap.curr and amap.curr.area == "Daevon" then
        amap:print_log("GPS: Blaviken", true)
        amap:set_position(4058, true)
    end
end

