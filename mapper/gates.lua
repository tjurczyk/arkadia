function trigger_func_mapper_gates_wks_gate()
    if amap.walker then
        raiseEvent("amapGateStoppedWalker")
    else
        raiseEvent("amapGateStopped")
    end

    amap.gate_bind = "popros o otwarcie bramy"
    scripts.utils.echobind(gate_bind, nil, "Otworz brame", "opening_gate", 1)
end

function trigger_func_mapper_gates_gates()
    if amap.walker then
        raiseEvent("amapGateStoppedWalker")
    else
        raiseEvent("amapGateStopped")
    end

    local open_str = "zastukaj we wrota"
    if amap.id_to_open_gate[amap.curr.id] then
        open_str = amap.id_to_open_gate[amap.curr.id]
    end

    amap.gate_bind = open_str
    scripts.utils.echobind(open_str, nil, "Otworz brame", "opening_gate")
end

