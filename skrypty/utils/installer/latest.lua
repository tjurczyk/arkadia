scripts.latest = {
    url = "https://api.github.com/repos/tjurczyk/arkadia/releases/latest",
    file_name = getMudletHomeDir() .. "/latest.json"
}

function scripts.latest:get_latest_version(callback)
    scripts.event_register:register_event_handler("scripts.lates.get_latest_version", "sysDownloaDone", function(_, filename) scripts.latest:handle_download(_, filename, callback) end)
    downloadFile(scripts.latest.file_name, scripts.latest.url)
end

function scripts.latest:is_latest(falseCallback, trueCallback)
    scripts.latest:get_latest_version(function(version) scripts.latest:compare(version, falseCallback, trueCallback) end)
end

function scripts.latest:compare(version, falseCallback, trueCallback)
    local falseCallback = falseCallback or function() return false end
    local trueCallback = trueCallback or function() return true end

    if scripts.ver == version then
        return trueCallback()
    end

    local current_version = split(scripts.ver, "\.")
    local repository_version = split(version, "\.")
    for i = 1, math.max(table.size(current_version), table.size(repository_version))  do
            if (current_version[i] or "0") > (repository_version[i] or "0") then
                return trueCallback()
            end
    end
    return falseCallback()
end

function scripts.latest:handle_download(_, filename, callback)
    if filename ~= scripts.latest.file_name then
        return true
    end

    local file = io.open(scripts.latest.file_name, "rb")
    if file then
        local response = yajl.to_value(file:read("*a"))
        file:close()
        callback(response.name)
    end
end