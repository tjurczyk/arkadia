scripts = scripts or { ver = "4.62" }
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

function alias_func_skrypty_fake_combat(s)
    s = string.gsub(s, "%$", "\n")
    gmcp = {
        gmcp_msgs = {
            text = enc(s .. "\n"),
            type = "combat.avatar"
        }
        }
    raiseEvent("gmcp.gmcp_msgs", gmcp)
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
    if scripts.ui.info_hidden_value >= 15 then
        scripts.ui.info_hidden_value = "ok"
        scripts.ui.states_window_nav_states.hidden_state = 15
        disableTimer("hidden_timer")
    else
        scripts.ui.info_hidden_value = getEpoch() - scripts.ui.info_hidden_epoch
        scripts.ui.states_window_nav_states.hidden_state = scripts.ui.states_window_nav_states.hidden_state + 1
    end
    ateam:print_status()
    raiseEvent("hidden_state", scripts.ui.info_hidden_value)
end

function timer_func_skrypty_lamp_info_timer()
    scripts.inv.lamp:process_lamp_counter()
end

function timer_func_skrypty_cover_timer()
--pablo start
    
	local dt = scripts.ui.cover_epoch and getEpoch() - scripts.ui.cover_epoch or 0
    local state
    if dt > 5 then
        state = "<green>ok"
        disableTimer("cover_timer")
    else
        state = "<red>"..string.format("%.1f", dt)
    end
    scripts.ui.states_window_nav_states["guard_state"] = state
    raiseEvent("guard_state", state)
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