disableTimer("lamp_info_timer")
disableTrigger("lampa_timery_dopelnienie")

function scripts.inv.lamp:process_lamp_counter()
    scripts.inv.lamp.lamp_seconds_val = scripts.inv.lamp.lamp_seconds_val - 1

    for _, seconds_count in pairs(scripts.inv.lamp.lamp_warning_times) do
        if scripts.inv.lamp.lamp_seconds_val == seconds_count then
            cecho("\n<yellow> >> W lampie zostalo oleju na " .. seconds_to_clock(scripts.inv.lamp.lamp_seconds_val) .. ".\n\n")
        end
    end

    for _, seconds_count in pairs(scripts.inv.lamp.lamp_beeps) do
        if scripts.inv.lamp.lamp_seconds_val == seconds_count then
            raiseEvent("playBeep")
        end
    end

    local counter_color = scripts.ui["footer_info_green"]
    if scripts.inv.lamp.lamp_seconds_val <= scripts.inv.lamp.lamp_red_seconds then
        counter_color = scripts.ui["footer_info_red"]
    elseif scripts.inv.lamp.lamp_seconds_val <= scripts.inv.lamp.lamp_yellow_seconds then
        counter_color = scripts.ui["footer_info_yellow"]
    end
    scripts.ui.footer_info_lamp:echo("<font color='" .. scripts.ui["footer_info_normal"] .. "'>Lampa:</font> <font color='" .. counter_color .. "'>" .. seconds_to_clock(scripts.inv.lamp.lamp_seconds_val) .. "</font>")
end

function scripts.inv.lamp:take_bottle()
    scripts.inv:get_from_bag({"olej"}, "other", 1)
    send("napelnij lampe olejem")
end

function scripts.inv.lamp:empty_bottle()
    send("odloz olej")
    scripts.inv:get_from_bag({"olej"}, "other", 1)
    send("napelnij lampe olejem")
end

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
    scripts.utils.bind_functional_call(function() scripts.inv.lamp:empty_bottle() end, " >> Odloz olej, wez butelke do reki i napelnij lampe", false)
end

function trigger_func_skrypty_inventory_lampa_brak_butelki()
    selectCurrentLine()
    fg("yellow")
    resetFormat()
    scripts.utils.bind_functional_call(function() scripts.inv.lamp:take_bottle() end, " >> Wez butelke do reki.", false)
end

