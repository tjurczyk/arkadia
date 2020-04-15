-- -- for 'idz' command
-- function go_command(_, command)
-- if command == "idz" then
-- amap:find_next_dir_from_go_and_execute()
-- --local ret_val = amap:manual_go()
-- 
-- --if ret_val then
-- --  amap:follow(ret_val, false)
-- --end
-- end
-- end


function go_command()
    -- parses the gmcp exits and compares them with the dir_from_key to see
    -- if it can find the next direction. If so, it sets it as the next direction bind.
    if table.size(gmcp.room.info.exits) ~= 2 then
        return
    end

    local current_loc = amap.curr.id



    local en_pressed_short_dir = amap.long_to_short[amap.dir_from_key]
    local en_pressed_opposite_short_dir = amap.opposite_dir[amap.dir_from_key]
    local pl_long_dir = amap.english_to_polish[amap.short_to_long[en_pressed_opposite_short_dir]]

    local pl_long_next_dir = nil
    if gmcp.room.info.exits[1] == pl_long_dir then
        pl_long_next_dir = gmcp.room.info.exits[2]
    else
        pl_long_next_dir = gmcp.room.info.exits[1]
    end

    local end_long_next_dir = amap.polish_to_english[pl_long_next_dir]
    amap.next_dir_bind = end_long_next_dir
end

function amap:execute_next_direction_bind()
    -- executes the next direction bind if exists.
    if not amap.next_dir_bind then
        amap:print_log("nastepny kierunek nie odnaleziony")
        return
    end

    local next_dir_bind = amap.next_dir_bind
    amap.next_dir_bind = nil
    amap:keybind_pressed(next_dir_bind)
end

