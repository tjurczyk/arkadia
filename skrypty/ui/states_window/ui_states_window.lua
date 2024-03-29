function scripts.ui:setup_states_window()
    scripts.ui.states_window_name = "states_window"
    self:create_state_window(scripts.ui.states_window_name)
    if scripts.ui.separate_enemy_states then
        scripts.ui.enemy_states_window_name = "enemy_states_window"
        self:create_state_window(scripts.ui.enemy_states_window_name)
    else
        scripts.ui.enemy_states_window_name = "states_window"
    end
end

function scripts.ui:create_state_window(name)
    if not scripts.ui.states_windows_loaded[name] then
        scripts.ui.states_windows_loaded[name] = scripts.ui.window:new(name, "Kondycje", function() return not scripts.ui.states_window_no_wrap end)
    end
    clearUserWindow(name)
    setFontSize(name, scripts.ui.states_font_size)
    
    cecho(name, "<yellow:team_console_bg>Minikonsola, <cyan:team_console_bg>do kondycji <green:team_console_bg>zainicjowana poprawnie\n")
end

function scripts.ui:init_states_window_navbar()
    scripts.ui["states_window_nav_states"] = {}
    scripts.ui.cfg["states_window_nav_hash"] = {}
    scripts.ui.states_window_navbar_str = ""

    for k, v in pairs(scripts.ui.cfg.states_window_nav_elements) do
        scripts.ui.cfg.states_window_nav_hash[v] = true
        scripts.ui.cfg.states_window_nav_hash[scripts.ui:decode_states_window_navbar_key(v)] = true
    end

    for k, v in pairs(scripts.ui.cfg["states_window_nav_elements"]) do
        scripts.ui.states_window_nav_states[scripts.ui:decode_states_window_navbar_key(v)] = false
    end

    tempTimer(1, function() scripts.ui:navbar_updates(nil, true) end)
end

