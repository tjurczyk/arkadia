scripts.latest = scripts.latest or {
    url = "https://api.github.com/repos/tjurczyk/arkadia/releases/latest",
    file_name = getMudletHomeDir() .. "/latest.json"
}

--[[
    Get latest version of scripts

    Args:
    - callback (function) - function which will be called upon version retrieval with api response as object with release info
      refer to as an example: https://api.github.com/repos/tjurczyk/arkadia/releases/latest
--]]
function scripts.latest:get_latest_version(callback)
    scripts.latest.handler = scripts.event_register:force_register_event_handler(scripts.latest.handler, "sysDownloadDone", function(_, filename) scripts.latest:handle_download(_, filename, callback) end)
    downloadFile(scripts.latest.file_name, scripts.latest.url)
end

--[[
    Check if current version of scripts is latest

    Args:
    - false_callback (function) - call if version is not tha latest
    - true_callback (function) - call if version is latest
--]]
function scripts.latest:is_latest(false_callback, true_callback)
    scripts.latest:get_latest_version(function(release_info) scripts.latest:compare(release_info.tag_name, function() false_callback(release_info) end, true_callback) end)
end


function scripts.latest:compare(version, false_callback, true_callback)
    local false_callback = false_callback or function() return false end
    local true_callback = true_callback or function() return true end

    if scripts.ver == version then
        return true_callback()
    end

    local current_version_partials_list = split(scripts.ver, "\.")
    local repository_version_partial_list = split(version, "\.")
    for i = 1, math.max(table.size(current_version), table.size(repository_version_partial_list))  do
            if (current_version_partials_list[i] or "0") > (repository_version_partial_list[i] or "0") then
                return true_callback()
            end
    end
    return false_callback()
end

function scripts.latest:handle_download(_, filename, callback)
    if filename ~= scripts.latest.file_name then
        return true
    end

    scripts.event_register:kill_event_handler(scripts.latest.handler)

    -- try to read response from github api, deserialize it and call callback function with version number
    local file = io.open(scripts.latest.file_name, "rb")
    if file then
        local response = yajl.to_value(file:read("*a"))
        file:close()
        callback(response)
    end
end