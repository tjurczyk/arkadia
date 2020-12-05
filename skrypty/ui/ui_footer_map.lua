function scripts.ui:setup_footer_map()
    
    scripts.ui.footer_map_core_base_css = CSSMan.new([[
    background-color: rgba(]] .. scripts.ui.footer_r .. [[,]] .. scripts.ui.footer_g .. [[,]] .. scripts.ui.footer_b .. [[,0);
    font-family:]].. getFont() ..[[,Consolas,Monaco,Lucida Console,Liberation Mono,DejaVu Sans Mono,Bitstream Vera Sans Mono,Courier New, monospace;
  ]] .. amap.ui.normal_button)

    scripts.ui.footer_map:setStyleSheet(scripts.ui.footer_map_core_base_css:getCSS())

  
    amap.ui.mapper_container = Geyser.HBox:new({
        name = "amap.ui.mapper_container",
        x = 0,
        y = 0,
        width = "100%",
        height = "100%",
    }, scripts.ui.footer_map)


    amap.ui.compass.box = Geyser.HBox:new({
        name = "amap.ui.compass.box",
        width = "100%",
        h_stretch_factor = 3,
    }, amap.ui.mapper_container)

    amap.ui.compass.right_box = Geyser.HBox:new({
        name = "amap.ui.compass.right_box",
        h_stretch_factor = 1,
    }, amap.ui.mapper_container)

    amap.ui.compass.right_special_box = Geyser.VBox:new({
        name = "amap.ui.compass.right_special_box",
        h_stretch_factor = 4,
    }, amap.ui.mapper_container)

    amap.ui.compass.row1 = Geyser.VBox:new({
        name = "amap.ui.compass.row1",
    }, amap.ui.compass.box)
    amap.ui.compass.row2 = Geyser.VBox:new({
        name = "amap.ui.compass.row2",
    }, amap.ui.compass.box)
    amap.ui.compass.row3 = Geyser.VBox:new({
        name = "amap.ui.compass.row3",
    }, amap.ui.compass.box)
    amap.ui.compass.row4 = Geyser.VBox:new({
        name = "amap.ui.compass.row4",
    }, amap.ui.compass.right_box)

    amap.ui.compass.button_nw = Geyser.Label:new({
        name = "amap.ui.compass.button_nw",
        fontSize = scripts.ui.footer_map_font_size,
        message = [[<center>\</center>]]
    }, amap.ui.compass.row1)
    amap.ui.compass.button_nw:setStyleSheet(scripts.ui.footer_map_core_base_css:getCSS())
    amap.ui.compass.button_nw:setClickCallback("compass_click", "nw")
    setLabelOnEnter("amap.ui.compass.button_nw", "compass_on_enter", "nw")
    setLabelOnLeave("amap.ui.compass.button_nw", "compass_on_leave", "nw")
    setLabelCursor(amap.ui.compass.button_nw.name, "PointingHand")

    amap.ui.compass.button_w = Geyser.Label:new({
        name = "amap.ui.compass.button_w",
        fontSize = scripts.ui.footer_map_font_size,
        message = [[<center>- </center>]]
    }, amap.ui.compass.row1)
    amap.ui.compass.button_w:setStyleSheet(scripts.ui.footer_map_core_base_css:getCSS())
    amap.ui.compass.button_w:setClickCallback("compass_click", "w")
    setLabelOnEnter("amap.ui.compass.button_w", "compass_on_enter", "w")
    setLabelOnLeave("amap.ui.compass.button_w", "compass_on_leave", "w")
    setLabelCursor(amap.ui.compass.button_w.name, "PointingHand")

    amap.ui.compass.button_sw = Geyser.Label:new({
        name = "amap.ui.compass.button_sw",
        fontSize = scripts.ui.footer_map_font_size,
        message = [[<center>/</center>]]
    }, amap.ui.compass.row1)
    amap.ui.compass.button_sw:setStyleSheet(scripts.ui.footer_map_core_base_css:getCSS())
    amap.ui.compass.button_sw:setClickCallback("compass_click", "sw")
    setLabelOnEnter("amap.ui.compass.button_sw", "compass_on_enter", "sw")
    setLabelOnLeave("amap.ui.compass.button_sw", "compass_on_leave", "sw")
    setLabelCursor(amap.ui.compass.button_sw.name, "PointingHand")

    amap.ui.compass.button_n = Geyser.Label:new({
        name = "amap.ui.compass.button_n",
        fontSize = scripts.ui.footer_map_font_size,
        message = [[<center>|</center>]]
    }, amap.ui.compass.row2)
    amap.ui.compass.button_n:setStyleSheet(scripts.ui.footer_map_core_base_css:getCSS())
    amap.ui.compass.button_n:setClickCallback("compass_click", "n")
    setLabelOnEnter("amap.ui.compass.button_n", "compass_on_enter", "n")
    setLabelOnLeave("amap.ui.compass.button_n", "compass_on_leave", "n")
    setLabelCursor(amap.ui.compass.button_n.name, "PointingHand")

    amap.ui.compass.button_center = Geyser.Label:new({
        name = "amap.ui.compass.button_center",
        fontSize = scripts.ui.footer_map_font_size,
        message = [[<center>O</center>]]
    }, amap.ui.compass.row2)
    amap.ui.compass.button_center:setStyleSheet(scripts.ui.footer_map_core_base_css:getCSS())

    amap.ui.compass.button_s = Geyser.Label:new({
        name = "amap.ui.compass.button_s",
        fontSize = scripts.ui.footer_map_font_size,
        message = [[<center>|</center>]]
    }, amap.ui.compass.row2)
    amap.ui.compass.button_s:setStyleSheet(scripts.ui.footer_map_core_base_css:getCSS())
    amap.ui.compass.button_s:setClickCallback("compass_click", "s")
    setLabelOnEnter("amap.ui.compass.button_s", "compass_on_enter", "s")
    setLabelOnLeave("amap.ui.compass.button_s", "compass_on_leave", "s")
    setLabelCursor(amap.ui.compass.button_s.name, "PointingHand")

    amap.ui.compass.button_ne = Geyser.Label:new({
        name = "amap.ui.compass.button_ne",
        fontSize = scripts.ui.footer_map_font_size,
        message = [[<center>/</center>]]
    }, amap.ui.compass.row3)
    amap.ui.compass.button_ne:setStyleSheet(scripts.ui.footer_map_core_base_css:getCSS())
    amap.ui.compass.button_ne:setClickCallback("compass_click", "ne")
    setLabelOnEnter("amap.ui.compass.button_ne", "compass_on_enter", "ne")
    setLabelOnLeave("amap.ui.compass.button_ne", "compass_on_leave", "ne")
    setLabelCursor(amap.ui.compass.button_ne.name, "PointingHand")

    amap.ui.compass.button_e = Geyser.Label:new({
        name = "amap.ui.compass.button_e",
        fontSize = scripts.ui.footer_map_font_size,
        message = [[<center> -</center>]]
    }, amap.ui.compass.row3)
    amap.ui.compass.button_e:setStyleSheet(scripts.ui.footer_map_core_base_css:getCSS())
    amap.ui.compass.button_e:setClickCallback("compass_click", "e")
    setLabelOnEnter("amap.ui.compass.button_e", "compass_on_enter", "e")
    setLabelOnLeave("amap.ui.compass.button_e", "compass_on_leave", "e")
    setLabelCursor(amap.ui.compass.button_e.name, "PointingHand")

    amap.ui.compass.button_se = Geyser.Label:new({
        name = "amap.ui.compass.button_se",
        fontSize = scripts.ui.footer_map_font_size,
        message = [[<center>\</center>]]
    }, amap.ui.compass.row3)
    amap.ui.compass.button_se:setStyleSheet(scripts.ui.footer_map_core_base_css:getCSS())
    amap.ui.compass.button_se:setClickCallback("compass_click", "se")
    setLabelOnEnter("amap.ui.compass.button_se", "compass_on_enter", "se")
    setLabelOnLeave("amap.ui.compass.button_se", "compass_on_leave", "se")
    setLabelCursor(amap.ui.compass.button_se.name, "PointingHand")

    amap.ui.compass.button_u = Geyser.Label:new({
        name = "amap.ui.compass.button_u",
        fontSize = scripts.ui.footer_map_font_size,
        message = [[<center>^</center>]]
    }, amap.ui.compass.row4)
    amap.ui.compass.button_u:setStyleSheet(scripts.ui.footer_map_core_base_css:getCSS())
    amap.ui.compass.button_u:setClickCallback("compass_click", "u")
    setLabelOnEnter("amap.ui.compass.button_u", "compass_on_enter", "u")
    setLabelOnLeave("amap.ui.compass.button_u", "compass_on_leave", "u")
    setLabelCursor(amap.ui.compass.button_u.name, "PointingHand")

    amap.ui.compass.button_dummy = Geyser.Label:new({
        name = "amap.ui.compass.button_dummy",
        fontSize = scripts.ui.footer_map_font_size,
    }, amap.ui.compass.row4)

    if amap.mode == "follow" then
        amap.ui:mapper_mode(true)
    else
        amap.ui:mapper_mode(false)
    end

    amap.ui.compass.button_d = Geyser.Label:new({
        name = "amap.ui.compass.button_d",
        fontSize = scripts.ui.footer_map_font_size,
        message = [[<center>v</center>]]
    }, amap.ui.compass.row4)
    amap.ui.compass.button_d:setStyleSheet(scripts.ui.footer_map_core_base_css:getCSS())
    amap.ui.compass.button_d:setClickCallback("compass_click", "d")
    setLabelOnEnter("amap.ui.compass.button_d", "compass_on_enter", "d")
    setLabelOnLeave("amap.ui.compass.button_d", "compass_on_leave", "d")
    setLabelCursor(amap.ui.compass.button_d.name, "PointingHand")

    amap.ui.compass.button_special1 = Geyser.Label:new({
        name = "amap.ui.compass.button_special1",
        fontSize = scripts.ui.footer_map_font_size,
        message = [[<center>special1</center>]]
    }, amap.ui.compass.right_special_box)
    amap.ui.compass.button_special1:setStyleSheet(scripts.ui.footer_map_core_base_css:getCSS())
    amap.ui.compass.button_special1:setClickCallback("compass_click", "special1")
    setLabelOnEnter("amap.ui.compass.button_special1", "compass_on_enter", "special1")
    setLabelOnLeave("amap.ui.compass.button_special1", "compass_on_leave", "special1")
    setLabelCursor(amap.ui.compass.button_special1.name, "PointingHand")

    amap.ui.compass.button_special2 = Geyser.Label:new({
        name = "amap.ui.compass.button_special2",
        fontSize = scripts.ui.footer_map_font_size,
        message = [[<center>special2</center>]]
    }, amap.ui.compass.right_special_box)
    amap.ui.compass.button_special2:setStyleSheet(scripts.ui.footer_map_core_base_css:getCSS())
    amap.ui.compass.button_special2:setClickCallback("compass_click", "special2")
    setLabelOnEnter("amap.ui.compass.button_special2", "compass_on_enter", "special2")
    setLabelOnLeave("amap.ui.compass.button_special2", "compass_on_leave", "special2")
    setLabelCursor(amap.ui.compass.button_special2.name, "PointingHand")

    amap.ui.compass.button_special3 = Geyser.Label:new({
        name = "amap.ui.compass.button_special3",
        fontSize = scripts.ui.footer_map_font_size,
        message = [[<center>special3</center>]]
    }, amap.ui.compass.right_special_box)
    amap.ui.compass.button_special3:setStyleSheet(scripts.ui.footer_map_core_base_css:getCSS())
    amap.ui.compass.button_special3:setClickCallback("compass_click", "special3")
    setLabelOnEnter("amap.ui.compass.button_special3", "compass_on_enter", "special3")
    setLabelOnLeave("amap.ui.compass.button_special3", "compass_on_leave", "special3")
    setLabelCursor(amap.ui.compass.button_special3.name, "PointingHand")
end

