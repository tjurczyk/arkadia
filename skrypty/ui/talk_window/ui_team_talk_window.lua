function scripts.ui:setup_team_talk_window()
    if scripts.ui.separate_team_talk_window then
        local window = scripts.ui.window:new("team_talk_window", "Rozmowy druzyny", function() return not scripts.ui.separate_talk_window_no_wrap end)
        window:set_font_size(scripts.ui.separate_talk_window_font_size)
    end
end
