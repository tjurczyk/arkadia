scripts.plugins_installer = scripts.plugins_installer or {
    plugin_directory = getMudletHomeDir() .. "/plugins/",
    valid_extensions = {"zip", "mpackage"}
}

function scripts.plugins_installer:install_from_url(url)
    local file_name = url:match("\/([^\/]+)$")
    local plugin_name, extension = file_name:gmatch("(.+)%.(.+)$")()

    if extension ~= nil and not table.contains(self.valid_extensions, extension) then
        scripts:print_log("[WARN] Rozszerzenie moze byc nieprawidlowe. Oczekiwane rozszerzenia to .zip, .mpackage lub brak")
    end

    self.plugin_download_handler = scripts.event_register:force_register_event_handler("download_plugin", "sysDownloadDone", function(_, filename) self:handle_download(_, filename, plugin_name) end)
    self.plugin_zip = self.plugin_directory .. file_name
    downloadFile(self.plugin_zip, url)
    scripts:print_log("Pobieram plugin " .. plugin_name)
end

function scripts.plugins_installer:handle_download(_, filename, plugin_name)
    if filename ~= self.plugin_zip then
        return true
    end

    scripts.event_register:kill_event_handler(self.plugin_download_handler)
    scripts:print_log("Plugin pobrany. Rozpakowuje")
    scripts.event_register:register_event_handler("sysUnzipDone", function(event, ...) self:handle_unzip(event, plugin_name,  ...) end, true)
    scripts.event_register:register_event_handler("sysUnzipError", function(event, ...) self:handle_unzip(event, plugin_name,  ...) end, true)
    unzipAsync(self.plugin_zip, self.plugin_directory .. plugin_name)
end

function scripts.plugins_installer:handle_unzip(event, plugin_name, ...)
    if event == "sysUnzipDone" then
        scripts:print_log("Plugin " .. plugin_name .. " rozpakowany")
        load_plugin(plugin_name)
        os.remove(self.plugin_zip)
    elseif event == "sysUnzipError" then
        scripts:print_log("Blad podczas rozpakowywania pluginu")
    end
end

function alias_func_install_plugin()
    scripts.plugins_installer:install_from_url(matches[2])
end

