function scripts.ui:setup_talk_window()
    if scripts.ui.separate_talk_window then
        openUserWindow("talk_window")
        setFontSize("talk_window", scripts.ui.separate_talk_window_font_size)
        setFont("talk_window", getFont())
        scripts.ui:setup_wrap_talk_window()
    end
end

function scripts.ui:setup_wrap_talk_window()
    local col = round(scripts.ui.separate_talk_window_p_width * getColumnCount("talk_window"))
    if scripts.ui.separate_talk_window_no_wrap then
        col = 1000
    end
    setWindowWrap("talk_window", col)
end

