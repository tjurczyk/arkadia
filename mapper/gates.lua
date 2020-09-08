function trigger_func_mapper_gates_wks_gate()
    if amap.walker then
        raiseEvent("amapGateStoppedWalker")
    else
        raiseEvent("amapGateStopped")
    end

    amap.gate_bind = "popros o otwarcie bramy"
    cecho("\n<" .. scripts.ui:get_bind_color_backward_compatible() .. ">[bind <yellow>" .. scripts.keybind:keybind_tostring("opening_gate") .. "<" .. scripts.ui:get_bind_color_backward_compatible() .. ">] Otworz brame\n")
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
    cecho("\n<" .. scripts.ui:get_bind_color_backward_compatible() .. ">[bind <yellow>" .. scripts.keybind:keybind_tostring("opening_gate") .. "<" .. scripts.ui:get_bind_color_backward_compatible() .. ">] Otworz brame\n")
end

