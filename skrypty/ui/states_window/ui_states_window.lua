function scripts.ui:setup_states_window()
    scripts.ui.states_window_name = "states_window"

    if not scripts.ui.states_windows_loaded then
        openUserWindow(scripts.ui.states_window_name)
        scripts.ui.states_windows_loaded = true
    end

    clearUserWindow(scripts.ui.states_window_name)
    setFontSize(scripts.ui.states_window_name, scripts.ui.states_font_size)
    cecho(scripts.ui.states_window_name, "<yellow:team_console_bg>Minikonsola, <cyan:team_console_bg>do kondycji <green:team_console_bg>zainicjowana poprawnie\n")

    tempTimer(0.3, function() scripts.ui:setup_wrap_states_window() end)
end

function scripts.ui:setup_wrap_states_window()
    local col = round(scripts.ui.states_window_p_width * getColumnCount(scripts.ui.states_window_name))
    setWindowWrap(scripts.ui.states_window_name, col)
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

