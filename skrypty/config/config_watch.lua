scripts.config_watch = scripts.config_watch or {
    enabled = false
}

function scripts.config_watch:start(config)
    if self.handler then
        scripts.event_register:kill_event_handler(self.handler)
        removeFileWatch(self.config._config_file_path)
    end

    if not self.enabled then
        return
    end

    self.config = config
    self.handler = scripts.event_register:register_event_handler("sysPathChanged", function(_, path)
       self:path_changed(path)
    end)
    addFileWatch(self.config._config_file_path)
end

function scripts.config_watch:path_changed(path)
    if path == self.config._config_file_path then
        debugc("Plik konfiguracji " .. self.config._config_name .. " zostal zmieniony, przeladowuje konfiguracje.")
        scripts_load_v2_config(self.config._config_name)
    end
end