scripts.plugins_update_check = scripts.plugins_update_check or {
    plugins = {}
}

function scripts.plugins_update_check:github_check_version(plugin_name, repo)
    local cfg = {["plugin_name"] = plugin_name, ["repo"] = repo, ["storeKey"] = 'github_' .. repo .."_" .. plugin_name}
    cfg.url = "https://api.github.com/repos/" .. repo .. "/" .. plugin_name .. "/commits"
    for i = 1, #self.plugins do
        local config = self.plugins[i]
        if config.url == cfg.url then
            cfg.handlerId = registerAnonymousEventHandler("sysGetHttpDone", function(event, url, response) return self:github_on_GetHttpDone(url, response) end)
            getHTTP(cfg.url)
            return
        end
    end

    cfg.handlerId = registerAnonymousEventHandler("sysGetHttpDone", function(event, url, response) return self:github_on_GetHttpDone(url, response) end)
    table.insert(self.plugins, cfg)
    getHTTP(cfg.url)
end

function scripts.plugins_update_check:github_on_GetHttpDone(url, response)
    for i = 1, #self.plugins do
        local config = self.plugins[i]
        if config.url == url then
            local contents = yajl.to_value(response)
            local sha = contents[1].sha
            local State = scripts.state_store:get(config.storeKey) or {}
            if State.sha == nil then
                scripts.state_store:set(config.storeKey, {sha = sha})
            end
            if State.sha ~= nil and sha ~= State.sha then
                cecho("\n<CadetBlue>(skrypty)<tomato>: Plugin '<light_slate_blue>".. config.plugin_name .. "<tomato>' posiada nowa aktualizacje. Kliknij ")
                cechoLink("<green>tutaj", function() scripts.plugins_update_check:github_update(config, sha) end, "Aktualizuj", true)
                cecho("<tomato> aby ja pobrac.\n")
            end
            if config.handlerId ~= nil then
                killAnonymousEventHandler(config.handlerId)
                config.handlerId = nil
            end
            return
        end
    end
end

function scripts.plugins_update_check:github_update(config, update_sha)
    scripts.plugins_installer:install_from_url("https://codeload.github.com/" .. config.repo .. "/" .. config.plugin_name .. "/zip/master")
    local State = scripts.state_store:get(config.storeKey) or {}
    State.sha = update_sha
    scripts.state_store:set(config.storeKey, State)
end
