function amap_check_is_gate_room(...)
    if not arg then
        return nil
    end

    local gate = getRoomUserData(arg[2], "gate")
    if gate and gate ~= "" then
        amap.gate_bind = gate
        scripts.utils.echobind(gate, nil, "Otworz brame", "opening_gate", 1)
    end
end

registerAnonymousEventHandler("amapNewLocation", "amap_check_is_gate_room")
