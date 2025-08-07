function scripts.ui:setup_footer_closed()
    scripts.ui.bottom_closed = Geyser.Label:new({
        name = "scripts.ui.bottom_closed",
        x = "50%",
        y = -12,
        width = 12,
        height = 12,
        fontSize = 11,
    })
    scripts.ui.bottom_closed:hide()
    scripts.ui.bottom_closed:setColor(0, 0, 0)
    scripts.ui.bottom_closed:echo("˄")
    setLabelCursor(scripts.ui.bottom_closed.name, "PointingHand")
    scripts.ui.bottom_closed:setClickCallback("show_footer_clicked")
end

function show_footer_clicked()
    scripts.ui.bottom:show()
    scripts.ui.bottom_closed:hide()
    setBorderBottom(scripts.ui.footer_height)
end

function scripts.ui:setup_footer()
    if scripts.ui.bottom then
        scripts.ui.bottom:hide()
        scripts.ui.bottom = nil
    end

    scripts.ui.bottom = Geyser.Label:new({
        name = "scripts.ui.bottom",
        x = tostring(scripts.ui.footer_start) .. "%",
        y = -scripts.ui.footer_height,
        width = scripts.ui.footer_width .. "%",
        height = scripts.ui.footer_height,
    })

    scripts.ui.bottom:setStyleSheet(scripts.ui.current_theme:get_footer_stylesheet())
    local r, g, b = scripts.ui.footer_color:match("#?(%x%x)(%x%x)(%x%x)")
    scripts.ui.bottom:setColor(tonumber(r, 16), tonumber(g, 16), tonumber(b, 16))

    scripts.ui.footer_vertical = Geyser.VBox:new({
        name = "scripts.ui.footer_vertical",
        x = 0,
        y = 0,
        width = "100%",
        height = "100%"
    }, scripts.ui.bottom)

    scripts.ui.actions_container = Geyser.HBox:new({
        name = "scripts.ui.actions_container",
        x = 0,
        y = 0,
        width = "100%",
        height = scripts.ui.footer_actions_height,
        v_policy = Geyser.Fixed,
        fontSize = 14
    }, scripts.ui.footer_vertical)

    scripts.ui.footer = Geyser.HBox:new({
        name = "scripts.ui.footer",
        x = 0,
        y = 0,
        width = "100%",
        height = "100%"
    }, scripts.ui.footer_vertical)
    
    scripts.ui.footer_map = Geyser.Label:new({
        name = "scripts.ui.footer_map",
        h_stretch_factor = scripts.ui.footer_map_width_p,
    }, scripts.ui.footer)
    scripts.ui.footer_map:setStyleSheet([[
        margin: ]] .. scripts.ui.footer_map_height_margin ..[[ ]] .. scripts.ui.footer_map_width_margin .. [[;
    ]])
    

    scripts.ui.footer_main = Geyser.Label:new({
        name = "scripts.ui.footer_main",
        h_stretch_factor = 100 - scripts.ui.footer_map_width_p - scripts.ui.footer_info_width_p,
    }, scripts.ui.footer)

    local empty = CSSMan.new([[
        border: 0px;
    ]])

    scripts.ui.footer_main:setStyleSheet(empty:getCSS())
    
    scripts.ui:setup_footer_main()
    sendGMCP([[Char.state ()]])

    scripts.ui.footer_info = Geyser.Label:new({
        name = "scripts.ui.footer_info",
        h_stretch_factor = scripts.ui.footer_info_width_p
    }, scripts.ui.footer)

    scripts.ui.footer_info:setStyleSheet(empty:getCSS())

    scripts.ui.footer_info_box = Geyser.HBox:new({
        name = "scripts.ui.footer_info_box",
        x = 0,
        y = 0,
        width = "100%",
        height = "100%"
    }, scripts.ui.footer_info)

    scripts.ui.footer_info_box_main = Geyser.Label:new({
        name = "scripts.ui.footer_info_box_main",
    }, scripts.ui.footer_info_box)

    scripts.ui.footer_info_box_main:setStyleSheet(empty:getCSS())
    

    scripts.ui.footer_info_box_closing = Geyser.Label:new({
        name = "scripts.ui.footer_info_box_closing",
        width = 15,
        height = 15,
        fontSize = 11,
        h_policy = Geyser.Fixed,
        v_policy = Geyser.Fixed,
    }, scripts.ui.footer_info_box)
    
    scripts.ui.footer_info_box_closing:echo("˅")
    scripts.ui.footer_info_box_closing:setClickCallback("hide_footer_clicked")
    scripts.ui.footer_info_box_closing:setStyleSheet(empty:getCSS())
    setLabelCursor(scripts.ui.footer_info_box_closing.name, "PointingHand")

    scripts.ui:setup_footer_info()

    if amap then
        amap.ui.active = true
        scripts.ui:setup_footer_map()
    end
end

function hide_footer_clicked()
    scripts.ui.bottom:hide()
    scripts.ui.bottom_closed:show()
    setBorderBottom(10)
end

