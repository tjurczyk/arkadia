function scripts.ui:setup_gauge_mode1()
    local curr_row = scripts.ui.footer_main_labels[1]
    local curr_id = 2

    scripts.ui.gauge_back = CSSMan.new([[
    background-color: rgba(]] .. scripts.ui.footer_r .. [[,]] .. scripts.ui.footer_g .. [[,]] .. scripts.ui.footer_b .. [[,0);
    border-style: solid;
    border-color: white;
    border-width: 1px;
    border-radius: 5px;
    margin-right: 5px;
    margin-left: 5px;
    margin-top: 5px;
    margin-down: 5px;
    font-family:Consolas,Monaco,Lucida Console,Liberation Mono,DejaVu Sans Mono,Bitstream Vera Sans Mono,Courier New, monospace;
  ]])

    scripts.ui.gauge_front = CSSMan.new([[
    background-color: rgba(0,0,52,0);
    border-style: solid;
    border-color: white;
    border-width: 1px;
    border-radius: 5px;
    margin-right: 5px;
    margin-left: 5px;
    margin-top: 5px;
    margin-down: 5px;
    font-family:Consolas,Monaco,Lucida Console,Liberation Mono,DejaVu Sans Mono,Bitstream Vera Sans Mono,Courier New, monospace;
  ]])

    for k, v in pairs(scripts.ui.cfg["footer_items"]) do
        scripts.ui[scripts.ui["bar_to_id2"][v]] = Geyser.Gauge:new({
            name = "scripts.ui." .. scripts.ui["bar_to_id2"][v],
            fontSize = scripts.ui.footer_font_size,
            width = tostring(100 / scripts.ui.footer_main_items_per_row) .. "%",
            h_policy = Geyser.Fixed,
        }, curr_row)

        scripts.ui[scripts.ui["bar_to_id2"][v]].front:echo([[ <font color="black">]] .. scripts.ui["state_key_to_label_pre"][scripts.ui["bar_to_eng"][v]] .. [[</font>]])
        scripts.ui[scripts.ui["bar_to_id2"][v]].back:echo([[ <font color="white">]] .. scripts.ui["state_key_to_label_pre"][scripts.ui["bar_to_eng"][v]] .. [[</font>]])
        scripts.ui[scripts.ui["bar_to_id2"][v]]:setValue(1, 1)
        scripts.ui[scripts.ui["bar_to_id2"][v]].back:setStyleSheet(scripts.ui.gauge_back:getCSS())
        scripts.ui[scripts.ui["bar_to_id2"][v]].front:setStyleSheet(scripts.ui.gauge_front:getCSS())

        if k ~= 1 and k % scripts.ui.footer_main_items_per_row == 0 then
            curr_row = scripts.ui.footer_main_labels[curr_id]
            curr_id = curr_id + 1
        end
    end
end

