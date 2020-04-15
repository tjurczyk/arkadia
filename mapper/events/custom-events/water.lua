function amap_check_drinkable_room_event(...)
    if not arg or table.size(arg) ~= 4 then
        return nil
    end

    if getRoomUserData(arg[2], "drinkable") == "true" then
        cecho(scripts.ui.bind_color .. "\nbind <yellow>" .. scripts.keybind:keybind_tostring("drinking") .. ":" .. scripts.ui.bind_color .. " napij sie do syta wody\n")
    end
end

function amap:drinking_bind()
    send("napij sie do syta wody", false)
end

registerAnonymousEventHandler("amapNewLocation", "amap_check_drinkable_room_event")

