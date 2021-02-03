--[[
    Parses the current location with the direction used and sets next_go_dir bind if possible.
--]]
function amap:may_prepare_next_go_dir()
    amap.next_go_dir = nil
    if not amap.curr.exits or table.size(amap.curr.exits) ~= 2 then
        return
    end

    local en_pressed_short_dir = amap.long_to_short[amap.dir_from_key]
    local en_pressed_opposite_short_dir = amap.opposite_dir[amap.dir_from_key]

    for dir, _ in pairs(amap.curr.exits) do
        if dir ~= en_pressed_opposite_short_dir then
            amap.next_go_dir = amap.short_to_long[dir]
        end
    end
end

--[[
    Executes next go dir (if available).
--]]
function amap:execute_next_go_dir()
    -- executes the next go bind if exists.
    if not amap.next_go_dir then
        amap:print_log("nastepny kierunek nie odnaleziony")
        return
    end

    local next_go_dir = amap.next_go_dir
    amap.next_go_dir = nil
    amap:keybind_pressed(next_go_dir)
end

-- Support for Arkadia 'idz' below

--[[
    Initializes arkadia go dir command.
--]]
function amap:setup_arkadia_go_dir()
    amap.handlers.arkadia_idz_sys_data_send_request_event = scripts.event_register:force_register_event_handler(amap.handlers.arkadia_idz_sys_data_send_request_event, 'sysDataSendRequest', 'arkadia_go_command')
end

--[[
    Callback for 'sysDataSendRequest' that checks for Arkadia's go command.
--]]
function arkadia_go_command(_, command)
    if command == "idz" then
      local ret_val = amap:manual_go()
      if ret_val then
        amap:follow(ret_val, false)
      end
    end
  end

tempTimer(1.45, function () amap:setup_arkadia_go_dir() end)
