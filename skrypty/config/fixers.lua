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

function scripts.config_fixers.fix_beep(config)
    local entry = config._config["scripts.sounds.beep"]:gsub("\\", "/")
    if entry == string.format("%s/sounds.beep.wav", getMudletHomeDir()):gsub("\\", "/") or entry == "arkadia/sounds/beep.wav" then
        config._config["scripts.sounds.beep"] = "sounds/beep.wav"
        return true
    end
    return false
end

function scripts.config_fixers.fix_footer_color(config)
    local r = config._config["scripts.ui.footer_r"]
    local g = config._config["scripts.ui.footer_g"]
    local b = config._config["scripts.ui.footer_b"]
    local color = config._config["scripts.ui.footer_color"]
    local changed = false

    if not color and r and g and b then
        config._config["scripts.ui.footer_color"] = string.format("#%02X%02X%02X", r, g, b)
        changed = true
    end

    if config._config["scripts.ui.footer_r"] then
        config._config["scripts.ui.footer_r"] = nil
        changed = true
    end
    if config._config["scripts.ui.footer_g"] then
        config._config["scripts.ui.footer_g"] = nil
        changed = true
    end
    if config._config["scripts.ui.footer_b"] then
        config._config["scripts.ui.footer_b"] = nil
        changed = true
    end

    return changed
end
