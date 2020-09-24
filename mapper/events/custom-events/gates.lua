function amap_check_is_gate_room(...)
    if not arg or table.size(arg) ~= 4 then
        return nil
    end

    local gate = getRoomUserData(arg[2], "gate")
    if gate then
        amap.gate_bind = gate
        cecho("\n<" .. scripts.ui:get_bind_color_backward_compatible() .. ">[bind <yellow>" .. scripts.keybind:keybind_tostring("opening_gate") .. "<" .. scripts.ui:get_bind_color_backward_compatible() .. ">] Otworz brame\n")
    end
end

registerAnonymousEventHandler("amapNewLocation", "amap_check_is_gate_room")

