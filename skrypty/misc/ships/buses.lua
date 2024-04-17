function trigger_func_skrypty_misc_ships_buses_powoli_zatrzymuje_sie_dylizans()
    scripts.utils.bind_ship("wem;wsiadz do dylizansu;wlm", false, false)
end

function trigger_func_skrypty_misc_ships_buses_powoli_tracic_predkosc_powoz()
    scripts.utils.bind_ship("wyjscie", true, false)
end

function trigger_func_skrypty_misc_ships_buses_i_wsiada_do_dylizansu()
    scripts.utils.bind_ship("wem;wsiadz do dylizansu;wlm", false, false)
end

function trigger_func_skrypty_misc_ships_buses_powoz_zatrzymuje_sie()
    if line:match("powoli rusza w droge") then
        return
    end
    scripts.utils.bind_ship("wem;wsiadz do wozu;wsiadz do powozu;wlm", false, false)
end

function trigger_func_skrypty_misc_ships_buses_i_wsiada_do_powozu()
    scripts.utils.bind_ship("wem;wsiadz do wozu;wsiadz do powozu;wlm", false, false)
end

function trigger_func_skrypty_misc_ships_buses_dylizans()
    scripts.utils.bind_ship("wem;wsiadz do dylizansu;wlm", false, false)
end

function trigger_func_skrypty_misc_busses_bryczka_on()
    scripts.utils.bind_ship("wem;usiadz na bryczce;wlm", false, false)
end

function trigger_func_skrypty_misc_busses_bryczka_woz_off()
    scripts.utils.bind_ship("wstan", false, false)
end

function trigger_func_skrypty_misc_busses_woz_on()
    scripts.utils.bind_ship("wem;usiadz na bryczce;wlm", false, false)
end
