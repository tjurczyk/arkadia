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


