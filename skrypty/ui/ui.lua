scripts.ui.bind_color = "LawnGreen"

function scripts.ui:get_bind_color_backward_compatible()
    local color = scripts.ui.bind_color
    if string.sub(color, 1, 1) == "<" then
        color = string.sub(color, 2, #color-1)
    end
    return color
end

function scripts.ui:run_setup()
    tempTimer(0.5, function()
        scripts.ui:setup()
    end)
end

function scripts.ui:setup()
    setBorderBottom(scripts.ui.footer_height)
    --scripts.ui.main_width, scripts.ui.main_height = getMainWindowSize()

    if not scripts.ui.map_loaded then
        --local main = Geyser.Container:new({x=0,y=0,width="100%",height="100%",name="mapper container"})

        --local mapper = Geyser.Mapper:new({
        --  name = "mapper",
        --  x = "70%", y = 0, -- edit here if you want to move it
        --  width = "30%", height = "50%"
        --}, main)
        if amap and amap.curr and amap.curr.id then
            centerview(amap.curr.id)
        end
        scripts.ui.map_loaded = true
    end

    --scripts.ui.real_footer_height = scripts.ui.footer_height
    --scripts.ui.real_footer_width = scripts.ui.footer_width/100 * scripts.ui.main_width

    scripts.ui:setup_states_window()
    scripts.ui:setup_talk_window()
    
    scripts.ui:setup_footer()
    scripts.ui:setup_footer_closed()
    raiseEvent("uiReady")
end

scripts.ui:run_setup()
