function trigger_func_skrypty_inventory_lampa_lampa_timery_start()
    enableTimer("lamp_info_timer")
    scripts.inv.lamp.working = true
    enableTrigger("lampa_timery_dopelnienie")
    selectCurrentLine()
    fg("orange")
    scripts.inv.lamp.lamp_seconds_val = scripts.inv.lamp.lamp_seconds_default_start_val
    scripts.inv.lamp:process_lamp_counter()
    resetFormat()
end

function trigger_func_skrypty_inventory_lampa_lampa_timery_off()
    if scripts.inv.lamp.working == true then
        disableTimer("lamp_info_timer")
        scripts.inv.lamp.working = false
        disableTrigger("lampa_timery_dopelnienie")
    end

    selectCurrentLine()
    fg("orange")
    resetFormat()
    scripts.ui:info_lamp_update("")
end

function trigger_func_skrypty_inventory_lampa_lampa_timery_dopelnienie()
    selectCurrentLine()
    fg("yellow")
    resetFormat()
    scripts.inv.lamp.lamp_seconds_val = scripts.inv.lamp.lamp_seconds_default_start_val
    scripts.inv.lamp:process_lamp_counter()
end

function trigger_func_skrypty_inventory_lampa_pusta_butelka()
    selectCurrentLine()
    fg("yellow")
    resetFormat()

    if scripts.inv.lamp.lamp_empty_bottle_bind ~= "" then
        scripts.utils.bind_functional(scripts.inv.lamp.lamp_empty_bottle_bind, false)
    end
end

function trigger_func_skrypty_inventory_lampa_brak_butelki()
    selectCurrentLine()
    fg("yellow")
    resetFormat()
    cecho("\n\n<green> >> Wez butelke do reki.")

    if scripts.inv.lamp.lamp_no_bottle_bind ~= "" then
        scripts.utils.bind_functional(scripts.inv.lamp.lamp_no_bottle_bind, false)
    end
end

