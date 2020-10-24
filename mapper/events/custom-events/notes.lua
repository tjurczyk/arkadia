function amap.db:set_note(room_id, room_note)
    local room_to_set = amap.db:get_room_id(room_id)

    if not room_to_set or not room_note then
        error("Wrong input")
    end

    setRoomUserData(room_to_set, "note", room_note)
    amap:print_log("Nota lokacji <green>" .. tostring(room_to_set) .. "<tomato> ustawiona")
end

function amap_db_check_note()
    if amap.curr.id then
        if getRoomUserData(amap.curr.id, "note") ~= "" and amap.db.show_notes then
            --amap:print_log("<light_slate_blue>" .. getRoomUserData(amap.curr.id, "note"))
            cecho("\n<" .. scripts.ui:get_bind_color_backward_compatible() .. ">info: <" .. scripts.ui:get_bind_color_backward_compatible() .. ">" .. getRoomUserData(amap.curr.id, "note") .. "\n")
        end
    end
end

registerAnonymousEventHandler("amapNewLocation", "amap_db_check_note")

