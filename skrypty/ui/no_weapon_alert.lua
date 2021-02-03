scripts.ui.no_weapon_alert = scripts.ui.no_weapon_alert or {
    can_dispatch_alert = true,
    is_knocked_off = false,
}

function scripts.ui.no_weapon_alert:init()
    self.handler_no_weapon = scripts.event_register:register_singleton_event_handler(self.handler_no_weapon, "ateamFightingWithNoWeapon", function() self:show_alert() end)
    self.handler_weapon_knocked = scripts.event_register:register_singleton_event_handler(self.handler_weapon_knocked, "weaponKnockedOff", function() self.is_knocked_off = true end)
    self.handler_can_wield = scripts.event_register:register_singleton_event_handler(self.handler_can_wield, "canWieldAfterKnockOff", function() self.is_knocked_off = false end)
end

function scripts.ui.no_weapon_alert:show_alert()
    if self.can_dispatch_alert and not self.is_knocked_off then
        scripts.messages:warning("Bijesz bez broni")
        scripts.utils.bind_functional("dobadz wszystkich broni")
        if scripts.ui.cfg.states_window_navbar and table.contains(scripts.ui.cfg.states_window_nav_elements, "bron") then
            self:blink()
        end
        self.can_dispatch_alert = false
        tempTimer(3, function() self.can_dispatch_alert = true end)
    end
end

function scripts.ui.no_weapon_alert:blink()
    if self.blinkKillFunction then
        self.blinkKillFunction()
    end
    local text = scripts.ui.cfg.states_window_nav_printable_key_map["bron"]
    self.blinkKillFunction = scripts.ui.window_modifiers.blink(scripts.ui.states_window_name, text, 0.2, 30, 255, 0, 0)
    scripts.event_register:register_event_handler("weapon_state", function(_, state)
        if state then
            self.blinkKillFunction()
        else
            return true
        end
    end, true)
end

scripts.ui.no_weapon_alert:init()