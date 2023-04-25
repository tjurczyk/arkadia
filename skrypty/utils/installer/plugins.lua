scripts.plugins_installer = scripts.plugins_installer or {
    plugin_directory = getMudletHomeDir() .. "/plugins/",
    valid_extensions = { "zip", "mpackage" }
}

function scripts.plugins_installer:init()
    self.drop_handler = scripts.event_register:force_register_event_handler(self.drop_handler, "sysDropEvent", function(_, filepath, suffix) self:handle_drop(filepath, suffix) end)
end

function scripts.plugins_installer:install_from_url(url)
    local repo_owner, repo, format, branch = url:match("https://codeload%.github%.com/(.*)/(.*)/(.*)/(.*)")
    if not repo_owner then
        repo_owner, repo, branch = rex.match(url, "https://api\\.github\\.com/repos/(.*)/(.*)/zipball(?:/(.*))?")
        format = "zip"
        branch = branch or "default"
    end

    local plugin_name, file_name, extension
    if repo then
        file_name = repo .. "." .. format
        extension = "." .. format
    else
        file_name = url:match("/([^/]+)$")
    end

    plugin_name, extension = file_name:gmatch("(.+)%.(.+)$")()

    if extension == nil then
        extension = "zip"
        plugin_name = file_name
        file_name = file_name .. "." .. extension
    end

    if lfs.isdir(self.plugin_directory .. plugin_name .. "/.git/") then
        scripts:print_log("Chyba nie chcesz aktualizowac w ten sposob repozytorium pluginu? :)")
        return
    end

    if extension ~= nil and not table.contains(self.valid_extensions, extension) then
        scripts:print_log("[WARN] Rozszerzenie moze byc nieprawidlowe. Oczekiwane rozszerzenia to .zip, .mpackage lub brak")
    end

    self.plugin_download_handler = scripts.event_register:force_register_event_handler("download_plugin", "sysDownloadDone", function(_, filename)
        self:handle_download(_, filename, plugin_name, branch)
    end)
    self.plugin_zip = self.plugin_directory .. file_name
    downloadFile(self.plugin_zip, url)
    scripts:print_log("Pobieram plugin " .. plugin_name .. " (" .. url .. ")")
end

function scripts.plugins_installer:handle_download(_, filename, plugin_name, branch)
    if filename ~= self.plugin_zip then
        return true
    end

    local reference = os.time() .. plugin_name

    scripts.event_register:kill_event_handler(self.plugin_download_handler)
    scripts.event_register:register_event_handler("sysUnzipDone", function(event, ...)
        self:handle_unzip(event, plugin_name, reference, ...)
    end, true)
    scripts.event_register:register_event_handler("sysUnzipError", function(event, ...)
        self:handle_unzip(event, plugin_name, reference, ...)
    end, true)
    unzipAsync(self.plugin_zip, self.plugin_directory .. "/" .. reference)
end

function scripts.plugins_installer:handle_unzip(event, plugin_name, reference, ...)
    if event == "sysUnzipDone" then
        if reference then
            local base_name = self.plugin_directory .. reference
            local files = lfs.list_files(base_name)
            if table.size(files) == 1 then
                os.rename(base_name .. "/" .. files[1], self.plugin_directory .. plugin_name)
                scripts.installer.delete_dir(base_name)
            elseif table.size(files) > 1 then
                os.rename(self.plugin_directory .. plugin_name, self.plugin_directory .. plugin_name .. "_todelete")
                os.rename(base_name, self.plugin_directory .. plugin_name)
                scripts.installer.delete_dir(self.plugin_directory .. plugin_name .. "_todelete")
            end
        end
        scripts:print_log("Plugin " .. plugin_name .. " rozpakowany")
        load_plugin(plugin_name)
        os.remove(self.plugin_zip)
    elseif event == "sysUnzipError" then
        scripts:print_log("Blad podczas rozpakowywania pluginu")
    end
end

function scripts.plugins_installer:uninstall(plugin_name)
    if lfs.isdir(self.plugin_directory .. plugin_name .. "/.git/") then
        scripts:print_log("Chyba nie chcesz odinstalowac w ten sposob repozytorium pluginu? :)")
        return
    end
    uninstallModule(plugin_name)
    for k, plugin_name_to_check in pairs(scripts.plugins) do
        if plugin_name_to_check == plugin_name then
            table.remove(scripts.plugins, k)
            break
        end
    end
    scripts.installer.delete_dir(self.plugin_directory .. plugin_name)
    scripts:print_log("Plugin " .. plugin_name .. " odinstalowany")
end

function scripts.plugins_installer:handle_drop(filepath, suffix)
    if suffix ~= "arkadia" then
        return
    end

    local plugin_name, extension = filepath:gmatch(".+/(.+)%.(.+)$")()
    scripts.event_register:register_event_handler("sysUnzipDone", function(event, ...)
        self.plugin_zip = filepath
        self:handle_unzip(event, plugin_name, nil, ...)
    end, true)
    scripts.event_register:register_event_handler("sysUnzipError", function(event, ...)
        self.plugin_zip = filepath
        self:handle_unzip(event, plugin_name, nil, ...)
    end, true)
    
    unzipAsync(filepath, self.plugin_directory .. plugin_name)
end

function alias_func_install_plugin()
    scripts.plugins_installer:install_from_url(matches[2])
end

function alias_func_uninstall_plugin()
    scripts.plugins_installer:uninstall(matches[2])
end

scripts.plugins_installer:init()