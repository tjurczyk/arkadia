function scripts.ui.window_modify(windowName, text, ...)
    for i = 1, getLineNumber(windowName), 1 do
        moveCursor(windowName, 1, i)
        local position = selectString(windowName, text, 1)
        if position > -1 then
            for arg_i = 1, arg.n, 1 do
                arg[arg_i](windowName, { x = position, y = i}, text)
                selectString(windowName, text, 1)
            end
        end
    end
    deselect(windowName)
    moveCursorEnd(windowName)
end

scripts.ui.window_modifiers = scripts.ui.window_modifiers or {}

function scripts.ui.window_modifiers.surround(prefix, suffix)
    return function(windowName, position, text)
        moveCursor(windowName, position.x, position.y)
        cinsertText(windowName, prefix)
        moveCursor(windowName, position.x + scripts.utils.real_len(text) + scripts.utils.real_len(prefix), position.y)
        cinsertText(windowName, suffix)
        moveCursor(windowName, 1, position.y)
    end
end

function scripts.ui.window_modifiers.bg(r, g, b)
    return function(windowName, position, text)
        if not windowName then
            debugc("Nie mam nazwy okna?")
        end
        setBgColor(windowName, r,g,b)
    end
end

function scripts.ui.window_modifiers.fg(r, g, b)
    return function(windowName, position, text)
        setFgColor(windowName, r, g, b)
    end
end

function scripts.ui.window_modifiers.underline()
    return function(windowName, position, text)
        setUnderline(windowName, true)
    end
end

function scripts.ui.window_modifiers.blink(windowName, text, interval, time, r, g, b)
    local key = os.time()
    scripts.ui.window_modifiers[key] = true
    local timer = tempTimer(interval, function()
        scripts.ui.window_modifiers[key] = not scripts.ui.window_modifiers[key]
        ateam:print_status()
    end, true)
    local eventHandler = scripts.event_register:register_event_handler("printStatusDone",
        function()
            if scripts.ui.window_modifiers[key] then
                scripts.ui.window_modify(windowName, text, scripts.ui.window_modifiers.fg(r, g, b))
            end
        end)
        local killFunction =  function()
            scripts.event_register:kill_event_handler(eventHandler)
            killTimer(timer)
            ateam:print_status()
        end
    tempTimer(time, killFunction)
    return killFunction
end
