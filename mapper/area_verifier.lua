amap.area_verifier = amap.area_verifier or {
    coroutines = {}
}

local download_url = "https://arkadia.rpg.pl/klient/web_client/maps/%s.map"
local map_location = string.format("%s/tmp/%%s.map", getMudletHomeDir())
local max_width = 0

function amap.area_verifier:download_all_areas()
    for name,id in pairs(getAreaTable()) do
        amap.area_verifier:download_area(name)
    end
end

function amap.area_verifier:download_area(area_name)
    local map_file = string.format(map_location, area_name)
    downloadFile(map_file, string.format(download_url, area_name))
    local handler = function(_, filename)
        if filename ~= map_file then return end
        coroutine.resume(self.coroutines[area_name])
    end
    registerAnonymousEventHandler("sysDownloadDone", handler)
    registerAnonymousEventHandler("sysDownloadError", handler)
end


function amap.area_verifier:verify_all_areas(print)
    for name,id in pairs(getAreaTable()) do
        amap.area_verifier:read_area(name, print)
    end
end

function amap.area_verifier:convert_map()
    for name,id in pairs(getAreaTable()) do
        amap.area_verifier:migrate_area(name, false)
    end
end

function amap.area_verifier:reader(area_name, print_missing, operation)
    self.coroutines[area_name] = coroutine.create(function()
        local area_id = getAreaTable()[area_name]
        local map_file = string.format(map_location, area_name)
        if not io.exists(map_file) then
            self:download_area(area_name)
            coroutine.yield()
        end
        local area_file = io.open(map_file)
        local missing = {}
        if area_file then
            if print_missing then
                echo(string.rep("=", 150) .. scripts.utils.str_pad(area_name, 50, "center") .. string.rep("=", 150) .. "\n")
            end
            local y = 1
            for line in area_file:lines() do
                line = utf8.gsub(line, "ą", "a")
                line = utf8.gsub(line, "ć", "c")
                line = utf8.gsub(line, "ę", "e")
                line = utf8.gsub(line, "ł", "l")
                line = utf8.gsub(line, "ó", "o")
                line = utf8.gsub(line, "ń", "n")
                line = utf8.gsub(line, "ś", "s")
                line = utf8.gsub(line, "ż", "z")
                line = utf8.gsub(line, "ź", "z")
                max_width = math.max(max_width, line:len())
                for x = 1, line:len(), 1 do
                    local sign = line:sub(x, x)
                    local room_color = "white"
                    if (sign:find("%u") or sign:find("%d")) and sign ~= "X" then
                    if not operation(x, y, 0, area_id) then
                            room_color = "red"
                            table.insert(missing, {x = x , y = y})
                        end
                    end
                    if print_missing then
                        cecho(string.format("<%s>%s", room_color, sign))
                    end
                end
                if print_missing then
                    echo("\n")
                end
                y = y + 1
            end
            area_file:close()
        end
        if table.size(missing) > 0 then
            cecho(string.format("<red>%s - %s lokacji ma bledne koordynaty\n", area_name, table.size(missing)))
        else
            cecho(string.format("<green>%s - zgodna z koordynatami GMCP\n", area_name))
        end
        self.coroutines[area_name] = nil
    end)
    coroutine.resume(self.coroutines[area_name])
end

-- migration only
function amap.area_verifier:migrate_area(area_name, print_missing)
    self:reader(area_name, print_missing, function(x, y, z, area_id)
        local rooms = getRoomsByPosition(area_id, x, -y, 0)
        if table.size(rooms) == 1 then
            setRoomIDbyHash(rooms[0], amap:generate_hash(x, y, 0, area_name))
            return true
        end
        return false
    end)
end

function amap.area_verifier:read_area(area_name, print_missing)
    self:reader(area_name, print_missing, function(x, y, z, area_id)
        return getRoomIDbyHash(amap:generate_hash(x, y, z, area_name)) ~= -1
    end)
end
