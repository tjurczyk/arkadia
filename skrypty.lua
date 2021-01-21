scripts = scripts or { ver = "4.19" }
scripts.event_handlers = scripts.event_handlers or {}

function alias_func_skrypty_help()
    scripts:print_help()
end

function alias_func_skrypty_aliasy_help()
    scripts:alias_print_help()
end

function alias_func_skrypty_bindy_help()
    scripts.keybind:print_help()
end

function alias_func_skrypty_fake()
    local s = matches[2]

    s = string.gsub(s, "%$", "\n")
    feedTriggers("\n" .. s .. "\n")
    echo("\n")
end

function alias_func_skrypty_lua_code()
    local f, e = loadstring("return " .. matches[2])
    if not f then
        f, e = assert(loadstring(matches[2]))
    end

    local r = f()
    if r ~= nil then display(r) end
end

function timer_func_skrypty_hidden_timer()
    if scripts.ui.info_hidden_value == 14 then
        scripts.ui.info_hidden_value = "ok"
        scripts.ui.states_window_nav_states.hidden_state = 15
        disableTimer("hidden_timer")
    else
        scripts.ui.info_hidden_value = scripts.ui.info_hidden_value + 1
        scripts.ui.states_window_nav_states.hidden_state = scripts.ui.states_window_nav_states.hidden_state + 1
    end
    ateam:print_status()
    raiseEvent("hidden_state", scripts.ui.info_hidden_value)
end

function timer_func_skrypty_lamp_info_timer()
    scripts.inv.lamp:process_lamp_counter()
end

function timer_func_skrypty_cover_timer()
    if scripts.ui.cover_wait_time == 1 then
        scripts.ui.cover_wait_time = "ok"
        scripts.ui.states_window_nav_states["guard_state"] = "ok"
        disableTimer("cover_timer")
    else
        scripts.ui.cover_wait_time = scripts.ui.cover_wait_time - 1
        scripts.ui.states_window_nav_states["guard_state"] = scripts.ui.states_window_nav_states["guard_state"] - 1
    end
    raiseEvent("guard_state", scripts.ui.cover_wait_time)
end

function timer_func_skrypty_order_timer()
    if scripts.ui.order_wait_time == 1 then
        scripts.ui.order_wait_time = "ok"
        scripts.ui.states_window_nav_states["order_state"] = "ok"
        disableTimer("order_timer")
    else
        scripts.ui.order_wait_time = scripts.ui.order_wait_time - 1
        scripts.ui.states_window_nav_states["order_state"] = scripts.ui.states_window_nav_states["order_state"] - 1
    end
    raiseEvent("order_state", scripts.ui.order_wait_time)
end

