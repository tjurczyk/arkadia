amap.path_display = amap.path_display or {
    highlighter = Highlight:new({}, color_table[amap.path_display_color], {150, 100, 255})
}

function amap.path_display_refresh()
    amap.path_display.highlighter.color1_rgb_table = color_table[amap.path_display_color]
    amap.path_display.highlighter:refresh()
end

function amap.path_display:start(destination)
    if not tonumber(destination) then
        destination = amap.shortcuts:get_room_by_name(destination)
        if not destination then
            scripts:print_log("Podaj ID lub prawidlowa nazwe skrotu.")
            return
        end
    end
    self.destination = tonumber(destination)

    if self.destination == amap.curr.id then
        scripts:print_log("Jestes juz na tej lokacji.")
        return
    end

    self:show_destination()
    self.handler = scripts.event_register:force_register_event_handler(self.handler, "amapNewLocation", function() self:show_destination() end)
    registerMapInfo("GPS", function() return self:map_info() end)
    enableMapInfo("GPS")
    if not getPath(amap.curr.id, self.destination) then
        scripts:print_log("Aktualnie nie jestem w stanie znalezc sciezki do lokacji " .. destination)
    end
end


function amap.path_display:stop()
    self.highlighter:clear()
    scripts.event_register:kill_event_handler(self.handler)
    disableMapInfo("GPS")
    killMapInfo("GPS")
end

function amap.path_display:show_destination()
    if amap.curr.id == self.destination then
        self:stop()
        return
    end
    self.highlighter:clear()
    if getPath(amap.curr.id, self.destination) then
        self.highlighter:set_locations(speedWalkPath)
        self.highlighter:on()
    end
end

function amap.path_display:map_info()
    return string.format("Sciezka do %d | Odleglosc: %s", self.destination, #speedWalkPath > 0 and #speedWalkPath or "?"), true
end

function alias_func_prowadz(id)
    amap.path_display:start(id)
end

function alias_func_prowadz_stop()
    amap.path_display:stop()
end