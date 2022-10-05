amap.map_update = amap.map_update or {
    automatic = false
}

function amap.map_update:init()
   self:check_for_update()
end

local function compare(repository_version, map_version)
    local current_version_partials_list = split(map_version or "0.0.0", "\\.")
    local repository_version_partial_list = split(repository_version, "\\.")
    for i = 1, math.max(table.size(current_version_partials_list), table.size(repository_version_partial_list)) do
        if tonumber(current_version_partials_list[i] or "0") > tonumber(repository_version_partial_list[i] or "0") then
            return false
        elseif tonumber(current_version_partials_list[i] or "0") < tonumber(repository_version_partial_list[i] or "0") then
            return true
        end
    end
end

function amap.map_update:check_for_update()
    HttpClient:get("https://api.github.com/repos/Delwing/arkadia-mapa/releases/latest", {}, function(response)
        local map_version = getMapUserData("version")
        local repository_version = response.tag_name
        if compare(repository_version, map_version) then
            if self.automatic then
                scripts.installer:download_mapper()
            else
                scripts:print_log_nobr("Nowa wersja mapy jest dostepna. ", true, "orange")
                cechoLink("<cornflower_blue>Kliknij aby pobrac.<reset>", function() scripts.installer:download_mapper() end, "Pobierz mape", true)
                echo("\n")
            end
        end
    end)
end

amap.map_update:init()