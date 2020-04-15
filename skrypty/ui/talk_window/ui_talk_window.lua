function scripts.ui:setup_talk_window()
    if scripts.ui.separate_talk_window then
        openUserWindow("talk_window")
        setFontSize("talk_window", scripts.ui.separate_talk_window_font_size)
        tempTimer(0.3, function() scripts.ui:setup_wrap_talk_window() end)
    end
end

function scripts.ui:setup_wrap_talk_window()
    local col = round(scripts.ui.separate_talk_window_p_width * getColumnCount("talk_window"))
    setWindowWrap("talk_window", col)
end

