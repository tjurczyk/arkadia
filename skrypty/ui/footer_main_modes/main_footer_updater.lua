local refresh_timer = nil

function scripts.ui:update_bars_mode(mode, redraw)
    if not mode and mode ~= "gauge" and mode ~= "label" then
        error("Invalid input")
    end

    -- if redraw == true -> refresh all stats
    -- if redraw == false -> refresh just changes from gmcp
    local source = gmcp.char.state 
    if redraw == true then 
        source = scripts.character.state
    end

    local any_changed = false;
    local footer_mode = scripts.ui.cfg.footer_mode

    for k, v in pairs(source) do
        -- k_index is the name of the ui item for this k (hp/fatigue etc)
        local k_index = k .. mode

        if k == "hp" then
            v = v + 1
        end

        local label = scripts.ui.state_key_to_label_pre[k]
        
        if scripts.ui.footer_bar[k] and scripts.ui[k_index] then

            local max_value = scripts.ui.footer_bar[k].max
            local color = scripts.ui.footer_bar[k].background[v]

            if mode == "gauge" then
                -- change color and set the right value
                scripts.ui[k_index]:setValue(v, max_value)
                scripts.ui.gauge_front:set("background-color", color)
                scripts.ui[k_index].front:setStyleSheet(scripts.ui.gauge_front:getCSS())
            elseif mode == "label" and footer_mode == "mode2" then
                local msg = scripts.ui:process_label_text_mode2(label, v, max_value, color)
                scripts.ui[k_index]:echo(msg)
            elseif mode == "label" and footer_mode == "mode3" then
                local msg = scripts.ui:process_label_text_mode3(label, v, max_value, color)
                scripts.ui[k_index]:echo(msg)
            elseif mode == "label" and footer_mode == "mode4" then
                local msg = scripts.ui:process_label_text_mode4(label, v, max_value, color)
                scripts.ui[k_index]:echo(msg)
            elseif mode == "label" and footer_mode == "mode5" then
                local msg, changed = scripts.ui:process_label_text_mode5(k, label, v, max_value, color)
                any_changed = any_changed or changed 
				scripts.ui[k_index]:echo(msg)        
            end
        end
    end

    if not redraw and any_changed and mode == "label" and footer_mode == "mode5" then
        local change_indicator_duration = scripts.ui.cfg.change_indicator_duration
        if refresh_timer then killTimer(refresh_timer) end
        refresh_timer = tempTimer(change_indicator_duration + 1, [[ scripts.ui:update_bars_mode("label", true) ]])
    end
end

function scripts.ui:process_label_text_mode2(prefix, val, max, color)
    if val == -1 then
        -- this happens at the start
        return
    end

    local str = [[<center><font color='#b3b3b3'>]] .. prefix .. [[: <font color="]] .. color .. [[">]]
    str = str .. "[" .. val .. ":" .. max .. "]</font></center>"
    return str
end

function scripts.ui:disable_guard()
    if scripts.ui.cfg["footer_mode"] == "mode1" then
        scripts.ui.gauge_front:set("background-color", "red")
        scripts.ui.guardgauge.front:setStyleSheet(scripts.ui.gauge_front:getCSS())
    elseif scripts.ui.cfg["footer_mode"] == "mode2" then
        scripts.ui.guardlabel:echo([[<center><font color="red">STOP</font></center>]])
    end

    if scripts.ui.timer_id then
        killTimer(scripts.ui.timer_id)
    end

    scripts.ui.timer_id = tempTimer(5, function() scripts.ui:enable_guard() end)
end

function scripts.ui:enable_guard()
    if scripts.ui.cfg["footer_mode"] == "mode1" then
        scripts.ui.gauge_front:set("background-color", "green")
        scripts.ui.guardgauge.front:setStyleSheet(scripts.ui.gauge_front:getCSS())
        scripts.ui.timer_id = nil
    elseif scripts.ui.cfg["footer_mode"] == "mode2" then
        scripts.ui.guardlabel:echo([[<center><font color="green">OK</font></center>]])
        scripts.ui.timer_id = nil
    end
end

