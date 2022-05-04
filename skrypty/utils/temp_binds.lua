scripts.temp_binds = scripts.temp_binds or {}
scripts.temp_binds.binds = { [1] = nil, [2] = nil, [3] = nil, [4] = nil, [5] = nil, [6] = nil, [7] = nil, [8] = nil, [9] = nil, [10] = nil }

function scripts.temp_binds.temp_bind_get(id)
    return scripts.temp_binds.binds[id]
end

function scripts.temp_binds.temp_bind_show_bind(id)
    return scripts.keybind:keybind_tostring("temp" .. id)
end

function scripts.temp_binds.temp_bind_set(id, action_string, silent)
    local was = nil
    if scripts.temp_binds.binds[id] then
        was = scripts.temp_binds.binds[id]
    end

    scripts.temp_binds.binds[id] = action_string
    scripts.keybind:enable_keybind("temp" .. tostring(id))
    local keybind_combination = scripts.keybind:_construct_printable("temp" .. id)
    if silent then
        return
    end

    if was then
        scripts:print_log("Dla binda '<LawnGreen>temp" .. id .. "<tomato>' (<LawnGreen>" .. keybind_combination .. "<tomato>) ustawilem: <LawnGreen>" .. action_string .. "<tomato>, (bylo: <LawnGreen>" .. was .. "<tomato>)")
    else
        scripts:print_log("Dla binda '<LawnGreen>temp" .. id .. "<tomato>' (<LawnGreen>" .. keybind_combination .. "<tomato>) ustawilem: <LawnGreen>" .. action_string)
    end
end

function scripts.temp_binds.execute_temp_bind(id)
    if scripts.temp_binds.binds[id] then
        local binds = scripts.utils:separate_bind(scripts.temp_binds.binds[id])
        for k, v in pairs(binds) do
            if v["delay"] then
                tempTimer(v["delay"], function() expandAlias(v["bind"]) end)
            else
                expandAlias(v["bind"])
            end
        end
    end
    raiseEvent("temporary_bind_executed", id)
end

function scripts.temp_binds.unbind_temp(silent)
    for k, _ in pairs(scripts.temp_binds.binds) do
        scripts.temp_binds.unbind_temp_single(k)
    end

    if not silent then
        scripts:print_log("Wyczyszczone")
    end
end

function scripts.temp_binds.unbind_temp_single(bind_id)
    scripts.temp_binds.binds[bind_id] = nil
    scripts.keybind:disable_keybind("temp" .. tostring(bind_id))
end

function scripts.temp_binds:pretty_print()
    cecho("+-------------------------- <green>Arkadia skrypty, ver " .. string.sub(scripts.ver .. "<grey> ----------------------------", 1, 38) .. "+\n")
    cecho("|                                                                                |\n")
    for var = 1, 4 do
        if scripts.temp_binds.binds[var] then
            cecho("|  <light_slate_blue>" .. string.sub(scripts.keybind:keybind_tostring("temp" .. tostring(var)) .. "<grey> - " .. scripts.temp_binds.binds[var] .. "                                                            ", 1, 84) .. "|\n")
        else
            cecho("|  <light_slate_blue>" .. string.sub(scripts.keybind:keybind_tostring("temp" .. tostring(var)) .. "<grey> - <brak>                                                              ", 1, 84) .. "|\n")
        end
    end
    cecho("|                                                                                |\n")
    cecho("+--------------------------------------------------------------------------------+\n")
end

scripts.utils.enable_keybinds(true)

