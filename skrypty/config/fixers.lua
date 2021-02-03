scripts.config_fixers = scripts.config_fixers or {}

--[[
    Functions to fix/change values in config on config load (e.g. schema correction mistakes, migration of old entries to new)
    Fixer functions should be defined as elements of scripts.config_fixer table
    They should return true if did some modifications to config
]]

--- Fixes "zaslon" key instead of "zaslona" in "scripts.ui.cfg.states_window_nav_printable_key_map" config key
function scripts.config_fixers.states_nav_printable_fixers(config)
    local entry = config._config["scripts.ui.cfg.states_window_nav_printable_key_map"]
    if entry.zaslon then
        entry.zaslona = entry.zaslon
        entry.zaslon = nil
        return true
    end
    return false
end