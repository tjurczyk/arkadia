function scripts.ui:setup_talk_window()
    if scripts.ui.separate_talk_window then
        local window = scripts.ui.window:new("talk_window", "Okno rozmow", scripts.ui.separate_talk_window_no_wrap)
        window:set_font_size(scripts.ui.separate_talk_window_font_size)
    end
end

function scripts.ui:setup_wrap_talk_window()
    local col = round(scripts.ui.separate_talk_window_p_width * getColumnCount("talk_window"))
    if scripts.ui.separate_talk_window_no_wrap then
        col = 1000
    end
    setWindowWrap("talk_window", col)
end

