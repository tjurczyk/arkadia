function amap:speedwalk_from_shortcut(s_name, delay)
    local room_id = amap.shortcuts:get_room_by_name(s_name)

    if room_id then
        if not amap.curr.id or amap.curr.id == -1 or not getPath(amap.curr.id, room_id) then
            amap:print_log("Nie ma polaczenia z aktualnej lokacji do docelowej")
            return
        end

        if delay then
            amap.walker_delay = tonumber(delay)
        else
            amap.walker_delay = amap.set_walker_delay
        end
        gotoRoom(room_id)
    else
        amap:print_log("Nie mam takiego skrotu, sprawdz '/pokaz_skroty'")
    end
end

function amap:speedwalk_from_id(room_id, delay)
    if not room_id then
        error("Wrong input")
    end

    if not amap.curr.id or amap.curr.id == -1 or not getPath(amap.curr.id, room_id) then
        amap:print_log("Nie ma polaczenia z aktualnej lokacji do docelowej")
        return
    end

    if delay then
        amap.walker_delay = tonumber(delay)
    else
        amap.walker_delay = amap.set_walker_delay
    end
    gotoRoom(room_id)
end

function doSpeedWalk()
    -- if drawing, do not use walker
    if amap.mode ~= "follow" then
        amap:print_log("Chodzik dziala tylko na wlaczonym chodzeniu")
        return
    end

    -- if the same location as current, don't run
    if amap.walker == false and (table.size(speedWalkPath) == 0 or amap.curr.id == speedWalkPath[table.size(speedWalkPath)]) then
        amap:print_log("Chcesz isc do aktualnej lokacji?")
        return
    end

    -- just in case., if walker is working, don't spawn another one
    if amap.walker == false then
        amap.dir_from_key = nil
        amap.speed_walk_dir = copy_table(speedWalkDir)
        amap.current_index = 1
        amap.walker = true
        amap.walker_dest = speedWalkPath[#speedWalkPath]
        amap:print_log("Rozpoczynam chodzik z opoznieniem: " .. round(amap.walker_delay, 2))

        -- if up/down change to u/d
        local curr_move = amap.speed_walk_dir[amap.current_index]
        local t_curr_move = amap.short_to_long[curr_move]

        if t_curr_move then
            amap.dir_from_key = t_curr_move
            amap:pre_on_key_event()
        else
            send(curr_move)
        end
        amap.walker_timer_id = tempTimer(amap.walker_delay, [[ amap:auto_walker() ]])

    else
        amap:print_log("Chodzik aktualnie pracuje, najpierw zastopuj uzywajac '/stop'")
    end
end

function amap:continue_speedwalk()
    if not amap.walker_dest then
        return
    end

    if amap.walker then
        amap:terminate_walker()
    end

    gotoRoom(amap.walker_dest)
end

function amap:auto_walker()
    -- we are on the next index of the path
    amap.current_index = amap.current_index + 1

    local curr_move = amap.speed_walk_dir[amap.current_index]
    local t_curr_move = amap.short_to_long[curr_move]

    if not curr_move then
        -- no index in speedWalkDir, end the walker
        amap.walker_dest = nil
        amap:stop_walker()
        return
    else
        if amap.delay == 0 then
            if t_curr_move then
                amap.dir_from_key = t_curr_move
                amap:pre_on_key_event()
            else
                send(curr_move)
            end
            amap:auto_walker()
        else
            if t_curr_move then
                amap.dir_from_key = t_curr_move
                amap:pre_on_key_event()
            else
                send(curr_move)
            end
            amap.walker_timer_id = tempTimer(amap.walker_delay, [[ amap:auto_walker() ]])
        end
    end
end

function amap:terminate_walker()
    -- this is run when some blocker terminates the walker
    if not amap.walker then
        return
    end

    amap:reset_walker()
    raiseEvent("amapWalkerTerminated")
    amap:print_log("Chodzik przerwany", true)
end

function amap:stop_walker()
    -- this is run when the walker finishes
    if not amap.walker then
        return
    end

    amap:reset_walker()
    raiseEvent("amapWalkerFinished")
    amap:print_log("Chodzik zakonczony", true)
end

function amap:reset_walker()
    -- it resets all the walker data
    if amap.walker_timer_id then
        killTimer(amap.walker_timer_id)
    end

    amap.walker_timer_id = nil
    amap.walker = false
    amap.current_index = nil
    amap.speed_walk_dir = nil
    amap.disable_walker = nil
    amap.walker_bind = nil
    amap.history = get_new_list()
    amap_add_location_history()
end

function amap:go_to_mail()
    if amap.go_to_room_mail then
        if not amap.curr.id or amap.curr.id == -1 or not getPath(amap.curr.id, amap.go_to_room_mail) then
            amap:print_log("Nie ma polaczenia z aktualnej lokacji do docelowej")
            return
        end

        gotoRoom(amap.go_to_room_mail)
        amap.go_to_room_mail = nil
        return true
    end
    return nil
end

function amap:walker_info()
    if amap.walker then
        amap:print_log("Aktualnie idziesz do lokacji '" .. getRoomName(amap.walker_dest) .. "' z opoznieniem " .. tostring(round(amap.walker_delay, 2)))
    else
        amap:print_log("Chodzik nie pracuje")
    end
end

function amap:modify_walker_delay(ratio)
    if amap.walker then
        amap.walker_delay = amap.walker_delay * ratio
        amap:print_log("Zmienilem opoznienie chodzika do " .. tostring(round(amap.walker_delay, 2)))
    else
        amap:print_log("Chodzik nie pracuje")
    end
end

function alias_func_mapper_walker_walker_stop()
    if amap.walker == false then
        amap:print_log("Chodzik nie jest wlaczony")
    else
        amap:terminate_walker()
    end
end

function alias_func_mapper_walker_set_walker_delay()
    amap.set_walker_delay = tonumber(matches[2])
    amap.walker_delay = tonumber(matches[2])
    amap:print_log("Opoznienie do chodzika ustawione na wartosc: " .. amap.set_walker_delay)
end

function alias_func_mapper_walker_walker_info()
    amap:walker_info()
end

function alias_func_mapper_walker_przyspiesz_chodzik()
    amap:modify_walker_delay(0.75)
end

function alias_func_mapper_walker_zwolnij_chodzik()
    amap:modify_walker_delay(1.25)
end

