function scripts.utils.bind_ship(command, if_locate, silent)
    scripts.utils.ship_key = command

    scripts.utils.echobind(command, nil, command, "enter_ship", 2)

    if not silent then
        raiseEvent("playBeep")
    end
end

function scripts.utils.reset_ship()
    scripts.utils.ship_key = nil
    killTimer(scripts.utils.ship_key_timer)
    scripts.utils.ship_key_timer = nil
end

function scripts.utils.execute_ship()
    if scripts.utils.ship_key then
        local sep = string.split(scripts.utils.ship_key, "[;#]")
        for k, v in pairs(sep) do
            expandAlias(v, true)
        end

        scripts.utils.ship_key = nil
    end
end

