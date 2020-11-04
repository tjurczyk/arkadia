function scripts.ui:setup_gauge_mode2()
    local curr_row = scripts.ui.footer_main_labels[1]
    local curr_id = 2

    for k, v in pairs(scripts.ui.cfg["footer_items"]) do
        scripts.ui[scripts.ui["bar_to_id1"][v]] = Geyser.Label:new({
            name = "scripts.ui." .. scripts.ui["bar_to_id1"][v],
            fontSize = scripts.ui.footer_font_size,
            width = tostring(100 / scripts.ui.footer_main_items_per_row) .. "%",
            h_policy = Geyser.Fixed,
            message = [[<center><font color='"..scripts.ui["footer_info_normal"].."'>]] .. scripts.ui["state_key_to_label_pre"][scripts.ui["bar_to_eng"][v]] .. [[: <font color="green">[0/0]</font></center>]]
        }, curr_row)

        scripts.ui[scripts.ui["bar_to_id1"][v]]:setStyleSheet([[
      background-color: rgba(]] .. scripts.ui.footer_r .. [[,]] .. scripts.ui.footer_g .. [[,]] .. scripts.ui.footer_b .. [[,0);
      font-family:]].. getFont() ..[[,Consolas,Monaco,Lucida Console,Liberation Mono,DejaVu Sans Mono,Bitstream Vera Sans Mono,Courier New, monospace;
    ]])

        if k ~= 1 and k % scripts.ui.footer_main_items_per_row == 0 then
            curr_row = scripts.ui.footer_main_labels[curr_id]
            curr_id = curr_id + 1
        end
    end
end

