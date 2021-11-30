function trigger_func_skrypty_ui_footer_elements_hidden_on()
    scripts.ui.info_hidden_value = 0
    scripts.ui.states_window_nav_states["hidden_state"] = 0
    enableTimer("hidden_timer")
    raiseEvent("hidden_state", 0)
end

function trigger_func_skrypty_ui_footer_elements_hidden_off()
    amap["went_sneaky"] = false
    scripts.ui.info_hidden_value = ""
    scripts.ui.states_window_nav_states["hidden_state"] = ""
    disableTimer("hidden_timer")
    raiseEvent("hidden_state", "")
end

function trigger_func_skrypty_ui_footer_elements_weapon_on()
    scripts.inv.weapon_grip = true
    raiseEvent("weapon_state", true)
end

function trigger_func_skrypty_ui_footer_elements_weapon_off()
    if matches[2] and string.match(matches[2], "burza piaskowa") then
        return
    end
    scripts.inv.weapon_grip = false
    raiseEvent("weapon_state", false)
end

function trigger_func_skrypty_ui_footer_elements_cover_action_success()
    ateam.cover_command = nil
    disableTimer("cover_timer")
-- pablo start
    scripts.ui.cover_epoch = getEpoch()
-- pablo end
    scripts.ui.states_window_nav_states["guard_state"] = 5
    enableTimer("cover_timer")
    raiseEvent("guard_state", 5)
end

function trigger_func_skrypty_ui_footer_elements_cover_action_fail()
    disableTimer("cover_timer")
-- pablo start
    scripts.ui.cover_epoch = getEpoch()
-- pablo end
    scripts.ui.states_window_nav_states["guard_state"] = 5
    enableTimer("cover_timer")
    raiseEvent("guard_state", 5)
end

function trigger_func_skrypty_ui_footer_elements_order_action()
    disableTimer("order_timer")
    scripts.ui.states_window_nav_states["order_state"] = 15
    scripts.ui.order_wait_time = 15
    enableTimer("order_timer")
    raiseEvent("order_state", 5)
end

