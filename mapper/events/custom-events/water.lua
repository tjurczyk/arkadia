function amap_check_drinkable_room_event(...)
    if not arg or table.size(arg) ~= 4 then
        return nil
    end

    if getRoomUserData(arg[2], "drinkable") == "true" then
        scripts.utils.echobind("napij sie do syta wody", function() amap:drinking_bind() end, "napij sie do syta wody", "drinking", 1)
    end
end

function amap:drinking_bind()
    send("napij sie do syta wody", false)
    if amap.water_animal then
        send("zwnapoj zwierze")
    end
end

registerAnonymousEventHandler("amapNewLocation", "amap_check_drinkable_room_event")

