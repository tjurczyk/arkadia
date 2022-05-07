function trigger_func_skrypty_ui_footer_elements_hidden_on()
    scripts.ui.hidden_state_epoch = getEpoch()
    resumeNamedTimer("arkadia", "hidden_timer")
end

function trigger_func_skrypty_ui_footer_elements_hidden_off()
    amap["went_sneaky"] = false
    scripts.ui.hidden_state_epoch = 0
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
    ateam.cover_command_click = nil
    scripts.ui.guard_state_epoch = getEpoch()
    resumeNamedTimer("arkadia", "cover_timer")
end

function trigger_func_skrypty_ui_footer_elements_cover_action_fail()
    scripts.ui.guard_state_epoch = getEpoch()
    resumeNamedTimer("arkadia", "cover_timer")
end

function trigger_func_skrypty_ui_footer_elements_order_action()
    scripts.ui.order_state_epoch = getEpoch()
    resumeNamedTimer("arkadia", "order_timer")
end

