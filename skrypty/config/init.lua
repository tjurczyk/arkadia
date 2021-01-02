scripts.config_init = scripts.config_init or {
    state_key = "config_initializer"
}

function scripts.config_init:init()
    self.handler = scripts.event_register:register_singleton_event_handler(self.handler, "loginSuccessful", function()
        self:suggest_init()
    end)
end

function scripts.config_init:suggest_init()
    if not gmcp.char.info.name then
        tempTimer(5, function() self:suggest_init() end)
    end
    
    local char_name = string.title(gmcp.char.info.name)
    if not scripts.config and (not scripts.state_store:get(self.state_key) or not scripts.state_store:get(self.state_key)[char_name]) then
        scripts:print_log("==============================================================================================", true)
        echo("\n")
        scripts:print_log("Konfiguracja skryptow nie zostala zaladowana.")
        scripts:print_log("Kliknij aby: ")
        local init_code = string.format([[scripts_init_v2_config("%s", "%s")]], string.title(char_name), amap.logged_name)
        cecho("<CadetBlue>(skrypty): ")
        cechoLink("<tomato>utworzyc konfiguracje dla " .. char_name, init_code, "Utworz konfiguracje", true)
        cecho(" || ")
        local turn_off_code = string.format([[scripts.config_init:turn_off("%s")]], char_name)
        cechoLink("<tomato>pomin tworzenie konifugracji i nie przypominaj mi o tym", turn_off_code, "Wylacz informacje o braku konfiguracji", true)
        echo("\n")
        scripts:print_log("==============================================================================================", true)
    end
end

function scripts.config_init:turn_off(char_name)
    local initializer_store = scripts.state_store:get(self.state_key) or {}
    initializer_store[char_name] = true
    scripts.state_store:set(self.state_key, initializer_store)
end

scripts.config_init:init()