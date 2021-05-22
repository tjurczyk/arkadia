function amap.db:set_bind(room_id, bind_str)
    local room_to_set = amap.db:get_room_id(room_id)

    if not room_to_set or not bind_str then
        error("Wrong input")
    end

    local binds = string.split(bind_str, "#")
    local bind_printable = ""

    for k, v in pairs(binds) do
        local bind = string.split(v, "*")
        if table.size(bind) > 2 then
            amap:print_log("Cos nie tak w parsowaniu")
            error("Wrong input")
        end

        bind_printable = bind_printable .. bind[1] .. ";"
    end

    setRoomUserData(room_to_set, "bind", bind_str)
    setRoomUserData(room_to_set, "bind_printable", bind_printable)
    amap:print_log("Utworzylem binda do: <green>" .. tostring(bind_printable))
end

function amap.db:reset_bind(room_id)
    local room_to_set = amap.db:get_room_id(room_id)

    if not room_to_set then
        error("Wrong input")
    end

    setRoomUserData(room_to_set, "bind", "")
    setRoomUserData(room_to_set, "bind_printable", "")
    amap:print_log("Bind dla lokacji<green> " .. tostring(room_to_set) .. "<tomato> usuniety")
end

function amap_db_check_bind()
    if amap.curr.id then
        if getRoomUserData(amap.curr.id, "bind") ~= "" then
            cecho("\n<" .. scripts.ui:get_bind_color_backward_compatible() .. ">bind <yellow>" .. scripts.keybind:keybind_tostring("special_exit") .. ":<" .. scripts.ui:get_bind_color_backward_compatible() .. "> " .. tostring(getRoomUserData(amap.curr.id, "bind_printable")) .. "\n\n")
        end
    end
end

function amap.db:execute_bind()
    if not amap.curr.id or getRoomUserData(amap.curr.id, "bind") == "" then
        return
    end
    misc:run_separeted_command(getRoomUserData(amap.curr.id, "bind"))
end

registerAnonymousEventHandler("amapNewLocation", "amap_db_check_bind")

