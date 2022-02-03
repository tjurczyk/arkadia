function scripts.ui:navbar_updates(name, force)
    if not scripts.ui.cfg.states_window_nav_hash[name] and not force then
        return
    end

    scripts.ui.states_window_navbar_str = ""

    for k, v in pairs(scripts.ui.cfg["states_window_nav_elements"]) do
        local key = scripts.ui:decode_states_window_navbar_key(v)
        local printable_key = scripts.ui.cfg.states_window_nav_printable_key_map[v]
        local printable_val = scripts.ui:navbar_get_printable_elem(key)
       
        if printable_val == nil then
            printable_val = scripts.ui.states_window_nav_states[name]
-- pablo start
            if type(printable_val) == "boolean" then
                printable_val = "?"
            end
-- pablo end
        end

        scripts.ui.states_window_navbar_str = scripts.ui.states_window_navbar_str .. printable_key .. "<white>: " .. printable_val

        if k ~= #scripts.ui.cfg["states_window_nav_elements"] then
            scripts.ui.states_window_navbar_str = scripts.ui.states_window_navbar_str .. "<white> | "
        end
    end

    ateam:print_status()
end

function scripts.ui:navbar_get_printable_elem(name)
    return scripts.ui.states_window_nav_printable_val_map[name][scripts.ui.states_window_nav_states[name]]
end

