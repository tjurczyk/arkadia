function amap_check_drinkable_room_event(...)
    if not arg or table.size(arg) ~= 4 then
        return nil
    end

    if getRoomUserData(arg[2], "drinkable") == "true" then
        cecho("<" .. scripts.ui:get_bind_color_backward_compatible() .. ">\nbind <yellow>" .. scripts.keybind:keybind_tostring("drinking") .. ":<" .. scripts.ui:get_bind_color_backward_compatible() .. "> napij sie do syta wody\n")
    end
end

function amap:drinking_bind()
    send("napij sie do syta wody", false)
    if amap.water_animal then
        send("zwnapoj zwierze")
    end
end

registerAnonymousEventHandler("amapNewLocation", "amap_check_drinkable_room_event")

