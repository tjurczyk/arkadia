scripts.ui.bind_color = "LawnGreen"

function scripts.ui:get_bind_color_backward_compatible()
    local color = scripts.ui.bind_color
    if string.sub(color, 1, 1) == "<" then
        color = string.sub(color, 2, #color-1)
    end
    return color
end

function scripts.ui:setup()
    if not scripts.ui.map_loaded then
        if amap and amap.curr and amap.curr.id then
            centerview(amap.curr.id)
        end
        scripts.ui.map_loaded = true
    end

    scripts.ui:setup_states_window()
    scripts.ui:setup_talk_window()
    
    scripts.ui:setup_footer()
    scripts.ui:setup_footer_closed()

    scripts.ui:init_states_window_navbar()
    setBorderBottom(scripts.ui.footer_height)

    raiseEvent("uiReady")
end

registerAnonymousEventHandler("sysLoadEvent", function() scripts.ui:setup() end)
