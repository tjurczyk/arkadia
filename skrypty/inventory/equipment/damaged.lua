scripts.inv.damaged = scripts.inv.damaged or {}

function scripts.inv.damaged:alert(message, type)
    creplaceLine("<tomato>\n\n[  ZNISZCZONY   ] " .. message .. "\n\n")
    resetFormat()

    raiseEvent("playBeep")
    scripts.ui:info_action_update("ZNI. " .. type)
end

function trigger_func_damaged_equipment()
    scripts.inv.damaged:alert(matches[1], matches[2])
end