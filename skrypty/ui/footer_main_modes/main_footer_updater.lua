function scripts.ui:update_bars_mode(mode)
    if not mode and mode ~= "gauge" and mode ~= "label" then
        error("Invalid input")
    end

    for k, v in pairs(gmcp.char.state) do
        -- k_index is the name of the ui item for this k (hp/fatigue etc)
        local k_index = k .. mode

        if k == "hp" then
            v = v + 1
        end

        if scripts.ui.footer_bar[k] and scripts.ui[k_index] then
            if mode == "gauge" then
                -- change color and set the right value
                scripts.ui[k_index]:setValue(v, scripts.ui.footer_bar[k].max)
                scripts.ui.gauge_front:set("background-color", scripts.ui.footer_bar[k].background[v])
                scripts.ui[k_index].front:setStyleSheet(scripts.ui.gauge_front:getCSS())
            elseif mode == "label" and scripts.ui.cfg.footer_mode == "mode2" then
                local msg = scripts.ui:process_label_text_mode2(scripts.ui.state_key_to_label_pre[k], v, scripts.ui.footer_bar[k].max, scripts.ui.footer_bar[k].background[v])
                scripts.ui[k_index]:echo(msg)
            elseif mode == "label" and scripts.ui.cfg.footer_mode == "mode3" then
                local msg = scripts.ui:process_label_text_mode3(scripts.ui.state_key_to_label_pre[k], v, scripts.ui.footer_bar[k].max, scripts.ui.footer_bar[k].background[v])
                scripts.ui[k_index]:echo(msg)
            elseif mode == "label" and scripts.ui.cfg.footer_mode == "mode4" then
                local msg = scripts.ui:process_label_text_mode4(scripts.ui.state_key_to_label_pre[k], v, scripts.ui.footer_bar[k].max, scripts.ui.footer_bar[k].background[v])
                scripts.ui[k_index]:echo(msg)
            end
        end
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

