function scripts.ui:setup_talk_window()
    if scripts.ui.separate_talk_window then
        local window = scripts.ui.window:new("talk_window", "Okno rozmow", function() return not scripts.ui.separate_talk_window_no_wrap end)
        window:set_font_size(scripts.ui.separate_talk_window_font_size)
    end
end
