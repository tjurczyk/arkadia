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

    tempTimer(0.1, function() scripts.ui:setup_states_window() end)
    tempTimer(0.2, function() scripts.ui:setup_talk_window() end)
    tempTimer(2, function() scripts.ui:setup_proportions() end)
    tempTimer(2.1, function() scripts.ui:setup_footer() end)
    tempTimer(2.2, function() scripts.ui:setup_footer_closed() end)
end

function scripts.ui:setup_proportions()
    scripts.ui.main_width, scripts.ui.main_height = getMainWindowSize()
    scripts.ui.real_footer_height = scripts.ui.footer_height
    scripts.ui.real_footer_width = scripts.ui.footer_width / 100 * scripts.ui.main_width
end

tempTimer(0.5, function() scripts.ui:setup() end)

